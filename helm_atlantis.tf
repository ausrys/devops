resource "helm_release" "atlantis" {
  name             = "atlantis"
  repository       = "https://runatlantis.github.io/helm-charts"
  chart            = "atlantis"
  namespace        = "atlantis"
  create_namespace = true


  # GitHub config block
  set {
    name  = "github.token"
    value = var.github_token
  }

  set {
    name  = "github.user"
    value = var.github_user
  }

  set {
    name  = "github.hostname"
    value = "github.com"
  }
  set {
    name  = "orgAllowlist"
    value = "github.com/${var.github_user}/${var.github_repo}"
  }

  set {
    name  = "github.secret"
    value = var.webhook_secret
  }
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}
