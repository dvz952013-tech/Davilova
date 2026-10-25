-- Execute no SQL Editor do seu projeto Supabase.
create table if not exists public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 display_name text not null default '',
 goal text not null default 'muscle' check (goal in ('muscle','fat')),
 place text not null default 'gym' check (place in ('gym','home')),
 level text not null default 'beginner' check (level in ('beginner','intermediate')),
 created_at timestamptz not null default now()
);
create table if not exists public.workout_sessions (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 title text not null,
 goal text not null check (goal in ('muscle','fat')),
 place text not null check (place in ('gym','home')),
 started_at timestamptz not null default now(),
 completed_at timestamptz
);
create table if not exists public.workout_entries (
 id uuid primary key default gen_random_uuid(),
 session_id uuid not null references public.workout_sessions(id) on delete cascade,
 user_id uuid not null references auth.users(id) on delete cascade,
 exercise_name text not null,
 prescription text not null,
 completed boolean not null default false,
 position integer not null default 0
);
create index if not exists sessions_user_started_idx on public.workout_sessions(user_id, started_at desc);
create index if not exists entries_session_idx on public.workout_entries(session_id, position);
alter table public.profiles enable row level security;
alter table public.workout_sessions enable row level security;
alter table public.workout_entries enable row level security;
drop policy if exists "profiles own" on public.profiles;
create policy "profiles own" on public.profiles for all to authenticated using (id = (select auth.uid())) with check (id = (select auth.uid()));
drop policy if exists "sessions own" on public.workout_sessions;
create policy "sessions own" on public.workout_sessions for all to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
drop policy if exists "entries own" on public.workout_entries;
create policy "entries own" on public.workout_entries for all to authenticated using (user_id = (select auth.uid()) and exists (select 1 from public.workout_sessions s where s.id = session_id and s.user_id = (select auth.uid()))) with check (user_id = (select auth.uid()) and exists (select 1 from public.workout_sessions s where s.id = session_id and s.user_id = (select auth.uid())));
