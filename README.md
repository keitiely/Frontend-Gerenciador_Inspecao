# 📱 App-Inspecao (Frontend - FazAgentes)

Aplicativo iOS desenvolvido para o projeto **FazAgentes**, parte do Trabalho Final da disciplina **Laboratório de Banco de Dados**.

A solução foi criada para auxiliar **Agentes de Saúde** e **Coordenadores de Vigilância Sanitária**, realizando inspeções domiciliares e enviando relatórios com imagens para um backend em Node.js conectado a um banco **híbrido** (MySQL + MongoDB).

---

## 🚀 Funcionalidades

A interface e permissões mudam automaticamente conforme o tipo de usuário autenticado (**AGENTE** ou **COORDENADOR**).

### 🔹 Perfil: Agente de Saúde
- Visualiza as quadras atribuídas pelo coordenador  
- Inicia e registra inspeções por residência
- Define status da visita:
  - `aceita`
  - `morador_ausente`
  - `recusada`
- Captura evidências utilizando `ImagePicker.swift` (câmera/galeria)
- Envia o relatório completo (`JSON + Base64`) através do `AddInspencaoViewModel.swift`, com armazenamento final no **MongoDB**

### 🔹 Perfil: Coordenador
- Visualiza **todas** as quadras e seus status:  
  `sem_agente`, `atribuida`, `concluida`
- Atribui agentes a quadras disponíveis
- Acessa e lê relatórios completos, incluindo imagens enviadas
- Acompanha produtividade dos agentes via `vw_inspecoes_por_agente`

---

## 🛠️ Tecnologias Utilizadas

| Componente | Tecnologia |
|------------|------------|
| Linguagem | Swift |
| Framework UI | SwiftUI |
| Arquitetura | MVVM |
| Networking | URLSession (REST / JSON) |
| Packages | SPM |
| Banco de Dados | MySQL + MongoDB (backend) |
| Backend | Node.js (API REST) |
[Repositório Backend](https://github.com/kenaygn/Backend-Gerenciador_Inspecao)

---

## 📋 Pré-requisitos

- macOS Sonoma (ou superior)  
- Xcode 15+  
- Simulador iOS ou dispositivo físico  
- Backend Node.js rodando e acessível na rede  

---

## ⚙️ Configuração e Execução

### 1️⃣ Clone o repositório
```bash
 git clone https://github.com/seu-usuario/app-inspecao.git
cd app-inspecao
## ⚙️ Configuração do Projeto

###  Abra o projeto no Xcode
- Abra o arquivo **`.xcodeproj`** (ou **`.xcworkspace`** caso utilize dependências externas)

---

###  Configure a baseURL da API
Localize o arquivo **`NetworkService.swift`** (ou variável semelhante) e ajuste a URL da API:
```
```swift
let baseURL = "...."

###  Use sempre o IP da máquina que está executando o backend, não utilize localhost.

```
### 2️⃣  Execute o App
Selecione um simulador ou dispositivo físico
Pressione CMD + R ou clique no botão ▶️ para rodar o projeto
```bash
<key>NSCameraUsageDescription</key>
<string>Precisamos de acesso à sua câmera para capturar fotos da inspeção.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Precisamos de acesso à sua galeria para importar fotos para a inspeção.</string>

