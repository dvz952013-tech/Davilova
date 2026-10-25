# Davilova Fit

SaaS fitness com interface preta e verde neon, autenticação, perfil, treinos e histórico.

## Estado atual

A interface e o código de integração Supabase estão implementados. **Ainda é necessário configurar um projeto Supabase e testar a integração.** Premium e pagamentos não estão ativos.

## Como ativar

1. Crie um projeto em [Supabase](https://supabase.com/dashboard).
2. No **SQL Editor**, execute todo o conteúdo de [supabase/schema.sql](supabase/schema.sql). Isso cria tabelas e políticas de Row Level Security (RLS).
3. Em **Project Settings > API** (ou Connect), copie a **Project URL** e a **publishable/anon key**.
4. Edite [config.js](config.js) substituindo os dois placeholders pelos valores públicos do seu projeto.
5. Em **Authentication > Providers > Email**, habilite login por e-mail e configure confirmação de e-mail conforme sua necessidade.
6. Em **Authentication > URL Configuration**, configure a URL do site publicado e URLs de redirecionamento permitidas.
7. Publique os arquivos na Netlify (site estático, sem comando de build; diretório de publicação: raiz do repositório).
8. Teste cadastro, confirmação de e-mail, login, perfil, iniciar sessão, marcar exercícios, finalizar e sair. Teste também com duas contas para verificar isolamento de dados.

## Estrutura

- `index.html`: landing, autenticação e dashboard
- `styles.css`: design responsivo
- `app.js`: autenticação e operações com Supabase
- `config.js`: URL e chave pública do Supabase (placeholders)
- `config.example.js`: modelo de configuração
- `supabase/schema.sql`: esquema e políticas de segurança

## Segurança e limitações

- Nunca use **service_role**, secret keys ou tokens privados no frontend ou no GitHub.
- A chave publishable/anon é projetada para uso no cliente, desde que RLS esteja habilitado corretamente.
- O histórico lista as 100 sessões mais recentes; métricas exibidas derivam dessa lista, não do histórico vitalício.
- Exercícios são exemplos gerais, não um plano clínico individualizado.
- Não há IA, planos personalizados avançados, cobrança, autorização Premium ou armazenamento de fotos nesta versão.
- O protótipo importa Supabase JS por CDN; é necessário acesso à internet para carregar a biblioteca.
