resource "helm_release" "atlantis" {
  name             = "atlantis"
  repository       = "https://runatlantis.github.io/helm-charts"
  chart            = "atlantis"
  namespace        = "atlantis"
  create_namespace = true


  # GitHub config block
  set {
    name  = "environmentSecrets.existingSecret"
    value = "atlantis-secrets"
  }
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}
