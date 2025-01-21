output "ci_build_role_arn" {
  value = aws_iam_role.ci_build.arn
}

output "ci_build_role_name" {
  value = aws_iam_role.ci_build.name
}

output "ci_pipeline_role_arn" {
  value = aws_iam_role.ci_pipeline.arn
}

output "ci_pipeline_role_name" {
  value = aws_iam_role.ci_pipeline.name
}

output "ecs_deployer_step_function_arn" {
  value = aws_iam_role.ecs_deployer_step_function.arn
}

output "ecs_deployer_step_function_name" {
  value = aws_iam_role.ecs_deployer_step_function.name
}

output "ecs_task_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "ecs_task_exec_arn" {
  value = aws_iam_role.ecs_task_exec.arn
}

output "ecs_task_exec_name" {
  value = aws_iam_role.ecs_task_exec.name
}
