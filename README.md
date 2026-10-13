# Caixa do Dia: guia para colocar no ar (Vercel + Supabase)

Site estático (um `index.html`) + banco Postgres com login no Supabase. Custo: R$ 0 nos planos gratuitos.

## Por que essa combinação
- **Vercel** hospeda a página (deploy automático a cada alteração, HTTPS, domínio grátis `*.vercel.app`).
- **Supabase** dá banco Postgres + login + regras de segurança por usuário (RLS), sem você escrever servidor.
- Alternativas que descartei: Neon/Vercel Postgres (exige criar API e login do zero), Vercel KV/Upstash (chave-valor, ruim para consultar), Google Sheets como banco (lento e sem login seguro).

## Passo a passo
1. **Supabase**: crie conta em supabase.com > *New project* (região São Paulo, guarde a senha do banco).
2. No projeto: *SQL Editor > New query*, cole o conteúdo de `supabase.sql` e clique **Run**.
3. *Project Settings > API*: copie **Project URL** e a chave **anon public**. Cole os dois em `config.js`.
4. **Vercel**: coloque esta pasta num repositório do GitHub (ou rode `npx vercel` dentro da pasta). Em vercel.com > *Add New > Project* importe o repositório. *Framework Preset: Other*, sem build command. Deploy.
5. Abra o endereço que a Vercel gerou, toque em **Criar conta (primeira vez)** e cadastre e-mail e senha (mín. 8 caracteres). Se o Supabase pedir confirmação, clique no link do e-mail e depois entre.
6. **Depois de criar sua conta**, no Supabase vá em *Authentication > Sign In / Providers > Email* e **desligue "Allow new users to sign up"**. Assim ninguém mais consegue criar conta no seu app.
7. No celular: abra o site no navegador > *Adicionar à tela inicial*. Vira um ícone de app.

## Como os dados são guardados
Tabela `caixa_docs`, uma linha por tipo de dado e por usuário: `cfg` (renda, fixas, faculdade, saldo), `parcelas`, `lanc` (lançamentos) e `fech` (fechamentos do dia). Tudo em JSON. As regras RLS impedem que qualquer outra conta leia as suas linhas.

## Rotina diária (2 minutos)
- Durante o dia: toque **Gasto** quando gastar (categorias Diário, Transporte e Lazer descontam do gasto diário previsto).
- À noite: **Fechar hoje**, informe quanto gastou de verdade; se quiser, confira com o saldo do banco.
- Uma vez por semana: **Atualizar saldo** com o valor real da conta.

## Recursos extras
- **Entradas recorrentes** (Ajustes): freela fixo, aluguel recebido etc. entram na previsão todo mês.
- **Limites por categoria** (Ajustes): a aba Lançar mostra quanto já gastou no mês e quanto resta.
- **Reserva de emergência** (Ajustes e aba Meses): alvo, quanto já guardou e em que mês você chega lá.
- **Importar extrato** (Ajustes > Seus dados): leia o CSV do banco. Por padrão importa só gastos, ignora linhas de fatura e pula lançamentos repetidos.

## Backup
Ajustes > *Baixar backup* gera um .json com tudo. *Restaurar backup* devolve. Faça de vez em quando.

## Se der problema
- "Banco de dados ainda não configurado": `config.js` ainda tem os textos COLE_AQUI.
- Dados só neste aparelho: você está sem login ou sem internet; entre de novo.
- Erro ao entrar logo após criar a conta: confirme o e-mail primeiro.
