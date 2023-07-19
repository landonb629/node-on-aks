locals { 
    argo = "argocd"
    argo_repo = "https://argoproj.github.io/argo-helm"
    argo_chart = "argo-cd"
    argo_namespace = "argocd"
}

resource "helm_release" "argocd" { 
    name = local.argo 
    repository = local.argo_repo 
    chart = local.argo_chart 
    namespace = local.argo_namespace 
    create_namespace = true 

    values = [ 
        file("argo-app.yml")
    ]
    depends_on = [ 
        module.eks-cluster
    ]
}