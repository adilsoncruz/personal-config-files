---
type: spec
project: "[[PRJ_Api_Mock_Studio]]"
status: approved
updated_at: 2026-11-17
tags:
  - spec
  - aws
  - multi-ec2
  - proxy
  - architecture
---

# 📋 Spec: Deployment Real-World Multi-EC2 (Checkout, Estoque, Pagamentos)

Conectado a: [[02_Specs_MOC]] | Projeto: [[PRJ_Api_Mock_Studio]]

## 🎯 Goal (Objetivo)
Separar os serviços de microsserviços em instâncias EC2 independentes na AWS (`us-east-1`), simulando o ambiente real de produção onde cada serviço possui sua própria máquina/IP, e o mock-proxy atua como Ingress (Wrap) em cada serviço individualmente, sincronizando com o Mock Studio central.

## 📐 Confirmed Requirements
1. **Topologia Multi-Máquina:**
   - **EC2 Studio Central:** Mantém a instância atual (`54.196.65.179`), hospedando o Studio UI, API de Controle e DynamoDB.
   - **EC2 Checkout (`ec2-checkout`):** Hospeda apenas o serviço de checkout + mock-proxy wrap.
   - **EC2 Estoque (`ec2-estoque`):** Hospeda apenas o serviço de estoque + mock-proxy wrap.
   - **EC2 Pagamentos (`ec2-pagamentos`):** Hospeda apenas o serviço de pagamentos + mock-proxy wrap.
2. **Modelo de Interceptação:**
   - Ingress Proxy (Wrap) rodando na porta 80 de cada EC2 de serviço, encaminhando para o container local na porta 8081.
   - Sincronização automática contínua de mocks via `STUDIO_URL=http://<IP_STUDIO>:3001/api/proxy/mocks`.
3. **Comunicação entre APIs:**
   - Checkout chama Estoque via `http://<IP_ESTOQUE>:80/stock` e Pagamentos via `http://<IP_PAGAMENTOS>:80/process`.
   - Protocolo inicial HTTP direto entre IPs públicos/privados para validar isolamento de rede; camada TLS/HTTPS e certificados adicionada na sequência.

## ✅ Acceptance Criteria
1. 3 instâncias EC2 (`t3.micro` ou `t3.medium`) criadas em `us-east-1` no Security Group `sg-0fca9fecbf0596073` com perfil IAM SSM.
2. Docker e Docker Compose configurados em cada EC2 executando apenas o seu respectivo serviço.
3. Teste ponta a ponta: requisição disparada na `EC2 Checkout` propaga para `EC2 Estoque` e `EC2 Pagamentos`, com interceptação e mock de respostas ocorrendo nas máquinas remotas.

## 🚧 Risks & Mitigations
- **Segurança de Portas:** Garantir que o Security Group permita tráfego nas portas 80 e 3001 entre as instâncias e para a Internet.
- **Sincronização com o Studio:** Configurar `STUDIO_URL` apontando para o IP da EC2 do Studio (`54.196.65.179:3001`) em cada instância de serviço.
