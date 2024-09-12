{{- define "fullName" -}}
{{- printf "%s" .Values.name -}}
{{- end -}}

{{- define "namespace" -}}
{{- printf "%s" .Values.name -}}
{{- end -}}

{{- define "imageMain" -}}
{{- $registry := .Values.image.registry -}}
{{- $repository := .Values.image.repository -}}
{{- $tag := .Values.image.tag | toString -}}
{{- printf "%s/%s:%s" $registry $repository $tag -}}
{{- end -}}

{{- define "saName" -}}
"{{ template "fullName" $ }}-sa"
{{- end -}}

{{- define "cmName" -}}
"{{ template "fullName" $ }}-cm"
{{- end -}}

{{- define "secretName" -}}
"{{ template "fullName" $ }}-secret"
{{- end -}}

{{- define "ingressName" -}}
"{{ template "fullName" $ }}-ingress"
{{- end -}}

{{- define "svcName" -}}
"{{ template "fullName" $ }}-svc"
{{- end -}}

{{- define "deploymentName" -}}
"{{ template "fullName" $ }}-deployment"
{{- end -}}

{{- define "jobPreName" -}}
{{ printf "%s" .Values.prerequisites.name }}-job
{{- end -}}