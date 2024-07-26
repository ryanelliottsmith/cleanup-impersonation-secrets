1) Modify the image defined resources.yaml to point to your private image, or to ghcr.io/ryanelliottsmith/cleanup-impersonation-secrets:latest
2) Apply resources.yaml, with kubectl or fleet/argo/whatever.
3) Monitor Job logs to completion
4) Cleanup resources
