#!/usr/bin/env python3
"""
Script para exportar objetos do Snowflake para arquivos
"""

import subprocess
import os
from pathlib import Path
import re

BACKUP_DIR = Path("snowflake_workspace/backup")

def run_sql(query):
    """Executa query SQL e retorna o resultado"""
    result = subprocess.run(
        ["snow", "sql", "-q", query],
        capture_output=True,
        text=True
    )
    return result.stdout

def extract_value(output):
    """Extrai o valor da primeira linha do resultado SQL"""
    lines = output.strip().split('\n')
    for line in lines:
        if line.startswith('|') and not line.startswith('|---') and 'GET_DDL' not in line:
            # Extrair o conteúdo entre pipes
            value = line.split('|')[1].strip() if '|' in line else line.strip()
            if value and value != 'GET_DDL':
                return value
    return None

def get_table_names(schema):
    """Obtém lista de tabelas do schema"""
    query = f"""
    SELECT table_name 
    FROM IE_DB.INFORMATION_SCHEMA.TABLES 
    WHERE table_schema = '{schema}' 
    AND table_type = 'BASE TABLE'
    ORDER BY table_name;
    """
    output = run_sql(query)
    
    tables = []
    for line in output.split('\n'):
        if '|' in line and not line.startswith('|---'):
            parts = [p.strip() for p in line.split('|')]
            if len(parts) > 1 and parts[1] and parts[1] != 'TABLE_NAME':
                tables.append(parts[1])
    
    return tables

def get_view_names(schema):
    """Obtém lista de views do schema"""
    query = f"""
    SELECT table_name 
    FROM IE_DB.INFORMATION_SCHEMA.VIEWS 
    WHERE table_schema = '{schema}'
    ORDER BY table_name;
    """
    output = run_sql(query)
    
    views = []
    for line in output.split('\n'):
        if '|' in line and not line.startswith('|---'):
            parts = [p.strip() for p in line.split('|')]
            if len(parts) > 1 and parts[1] and parts[1] != 'TABLE_NAME':
                views.append(parts[1])
    
    return views

def export_ddl(object_type, object_name, output_file):
    """Exporta DDL de um objeto"""
    query = f"SELECT GET_DDL('{object_type}', '{object_name}');"
    ddl = run_sql(query)
    
    # Extrair o DDL do output formatado
    clean_ddl = []
    capture = False
    for line in ddl.split('\n'):
        if '|' in line and not line.startswith('|---'):
            content = line.split('|')[1].strip() if len(line.split('|')) > 1 else ''
            if content and 'GET_DDL' not in content:
                capture = True
                clean_ddl.append(content)
        elif capture and line.strip():
            break
    
    if clean_ddl:
        output_file.parent.mkdir(parents=True, exist_ok=True)
        with open(output_file, 'w') as f:
            f.write('\n'.join(clean_ddl))
        return True
    return False

def main():
    print("🚀 Iniciando exportação de objetos do Snowflake...")
    print(f"📁 Diretório: {BACKUP_DIR}\n")
    
    # Criar diretórios
    (BACKUP_DIR / "schemas").mkdir(parents=True, exist_ok=True)
    (BACKUP_DIR / "tables" / "staging").mkdir(parents=True, exist_ok=True)
    (BACKUP_DIR / "views" / "staging").mkdir(parents=True, exist_ok=True)
    (BACKUP_DIR / "views" / "core").mkdir(parents=True, exist_ok=True)
    (BACKUP_DIR / "views" / "raw").mkdir(parents=True, exist_ok=True)
    
    # 1. Exportar Database
    print("📦 Exportando DATABASE...")
    export_ddl('DATABASE', 'IE_DB', BACKUP_DIR / 'database_IE_DB.sql')
    
    # 2. Exportar Schemas
    print("📂 Exportando SCHEMAS...")
    for schema in ['STAGING', 'CORE', 'RAW']:
        export_ddl('SCHEMA', f'IE_DB.{schema}', BACKUP_DIR / 'schemas' / f'{schema}.sql')
    
    # 3. Exportar Tabelas
    print("📊 Exportando TABLES do schema STAGING...")
    tables = get_table_names('STAGING')
    for table in tables:
        print(f"  - {table}")
        export_ddl('TABLE', f'IE_DB.STAGING.{table}', 
                  BACKUP_DIR / 'tables' / 'staging' / f'{table}.sql')
    
    # 4. Exportar Views
    for schema in ['STAGING', 'CORE', 'RAW']:
        print(f"👁️  Exportando VIEWS do schema {schema}...")
        views = get_view_names(schema)
        for view in views:
            print(f"  - {view}")
            export_ddl('VIEW', f'IE_DB.{schema}.{view}', 
                      BACKUP_DIR / 'views' / schema.lower() / f'{view}.sql')
    
    print("\n✅ Exportação concluída!")
    print(f"\n📁 Arquivos salvos em: {BACKUP_DIR}")
    print("\n🔄 Próximo passo:")
    print("   git add snowflake_workspace/backup/")
    print("   git commit -m 'backup: adiciona objetos do Snowflake'")
    print("   git push origin main")

if __name__ == '__main__':
    main()
