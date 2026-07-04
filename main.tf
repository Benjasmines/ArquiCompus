# 1. Configurar el proveedor de AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
}

provider "aws" {
  region = "us-east-1" # Cambia esto por tu región de preferencia
}

# 2. Bucket S3 
# Generamos un sufijo aleatorio para que el nombre del bucket sea único en todo el mundo
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "athena_resultados" {
  bucket        = "athena-resultados-investigacion-${random_id.bucket_suffix.hex}"
  force_destroy = true # Permite borrar el bucket con todo su contenido al hacer 'destroy'
}

# 3. Crear la base de datos lógica en Athena
resource "aws_athena_database" "mi_base_datos" {
  name   = "base_datos_investigacion"
  bucket = aws_s3_bucket.athena_resultados.id
}

# 4. Crear un Workgroup 
resource "aws_athena_workgroup" "mi_workgroup" {
  name = "workgroup_investigacion"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_resultados.bucket}/output/"
    }
  }
}