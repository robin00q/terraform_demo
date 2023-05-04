resource "aws_lb_target_group_attachment" "sjlee-terraform-lb-target-group-attachment" {
  count = length(var.compute_cloud_ids)

  target_group_arn = aws_alb_target_group.sjlee-terraform-aws-alb-target-group.arn
  target_id        = element("${var.compute_cloud_ids.*}", count.index)
}