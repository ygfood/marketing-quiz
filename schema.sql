-- マーケティング検定2級 演習アプリ 用テーブル定義
-- Supabaseの SQL Editor でこのファイルの内容をそのまま実行してください。
-- 万一Supabaseプロジェクトが消えても、このファイルをGitHubに保存しておけば
-- 新しいプロジェクトで同じ構造をすぐ再現できます。

create table if not exists public.quiz_history (
  id bigint generated always as identity primary key,
  area text not null,
  question text not null,
  correct boolean not null,
  ts timestamptz not null default now()
);

-- 行レベルセキュリティ（RLS）を有効化
alter table public.quiz_history enable row level security;

-- anonキー（アプリから使う公開キー）に対して、
-- このテーブルへの 参照・追加・削除 のみを許可するポリシー
-- （他のテーブルには一切影響しません。更新(update)は許可していません）

create policy "anon can select quiz_history"
  on public.quiz_history
  for select
  to anon
  using (true);

create policy "anon can insert quiz_history"
  on public.quiz_history
  for insert
  to anon
  with check (true);

create policy "anon can delete quiz_history"
  on public.quiz_history
  for delete
  to anon
  using (true);
