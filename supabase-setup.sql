-- DIGISYSTEM Supabase FINAL CLEANUP
-- Run this in Supabase Dashboard > SQL Editor > New query
-- Drops ALL old policies on orders and recreates a clean, secure set.

-- 1) Drop every existing policy on orders (old loose ones included)
drop policy if exists "allow anon insert" on public.orders;
drop policy if exists "allow authed read" on public.orders;
drop policy if exists "allow authed update" on public.orders;
drop policy if exists "allow authed delete" on public.orders;
drop policy if exists "allow service read" on public.orders;
drop policy if exists "allow service update" on public.orders;
drop policy if exists "allow service delete" on public.orders;
drop policy if exists "Enable insert for all users" on public.orders;
drop policy if exists "Enable read access for all users" on public.orders;
drop policy if exists "Enable update access for all users" on public.orders;
drop policy if exists "Enable delete access for all users" on public.orders;
drop policy if exists "Enable all access for all users" on public.orders;
drop policy if exists "Enable all for users based on user_id" on public.orders;

-- 2) Public visitors can ONLY insert (contact form)
alter table public.orders enable row level security;

create policy "allow anon insert"
on public.orders
for insert
to anon
with check (true);

-- 3) Signed-in admins (Supabase Auth) can read / update / delete
create policy "allow authed read"
on public.orders
for select
to authenticated
using (true);

create policy "allow authed update"
on public.orders
for update
to authenticated
using (true)
with check (true);

create policy "allow authed delete"
on public.orders
for delete
to authenticated
using (true);

-- Done. Now visitors can submit, ONLY logged-in admins can see/manage leads.