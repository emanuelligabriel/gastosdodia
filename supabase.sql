-- Rode este arquivo UMA vez no Supabase: SQL Editor > New query > cole tudo > Run.
create table if not exists public.caixa_docs (
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  kind       text not null check (kind in ('cfg','parcelas','lanc','fech')),
  data       jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, kind)
);

alter table public.caixa_docs enable row level security;
revoke all on public.caixa_docs from anon;

-- cada pessoa só enxerga e altera as próprias linhas
create policy "ler as proprias linhas"    on public.caixa_docs for select to authenticated using (user_id = (select auth.uid()));
create policy "criar as proprias linhas"  on public.caixa_docs for insert to authenticated with check (user_id = (select auth.uid()));
create policy "editar as proprias linhas" on public.caixa_docs for update to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "apagar as proprias linhas" on public.caixa_docs for delete to authenticated using (user_id = (select auth.uid()));
