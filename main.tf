# 1. Configurar el proveedor de AWS
provider "aws" {
  region = "us-east-1"
}

# 2. Bucket S3 
# Este bucket solo existirá para que Athena pueda depositar el output de sus queries.
resource "aws_s3_bucket" "athena_resultados" {
  bucket        = "mi-proyecto-athena-resultados-123456" 
  force_destroy = true
}

# 3. Crear la base de datos lógica en Athena
resource "aws_athena_database" "mi_base_analitica" {
  name   = "base_datos_investigacion"
  bucket = aws_s3_bucket.athena_resultados.id
}

# 4. Crear un Workgroup 
resource "aws_athena_workgroup" "mi_grupo_trabajo" {
  name = "workgroup_analitica_basica"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    # Aquí le indicamos a Athena dónde debe arrojar sus resultados temporalmente
    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_resultados.bucket}/output/"
    }
  }
}