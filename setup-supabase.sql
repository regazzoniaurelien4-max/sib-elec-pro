-- ================================================================
-- SCRIPT D'INSTALLATION SUPABASE — SIB.Elec
-- ================================================================
-- Copiez-collez ce script dans l'onglet "SQL Editor" de Supabase
-- puis cliquez sur "Run"
-- ================================================================

-- TABLE DEVIS
create table if not exists devis (
  id               uuid    default gen_random_uuid() primary key,
  user_id          uuid    references auth.users(id) on delete cascade not null,
  num              text    not null,
  client_nom       text    not null,
  client_societe   text,
  client_email     text,
  client_tel       text,
  client_adresse   text,
  client_cp        text,
  client_ville     text,
  chantier         text,
  montant_ht       numeric(12,2) default 0,
  montant_tva10    numeric(12,2) default 0,
  montant_tva20    numeric(12,2) default 0,
  montant_ttc      numeric(12,2) default 0,
  statut           text    default 'en-attente',   -- en-attente | accepte | refuse
  date_devis       date,
  date_validite    date,
  notes            text,
  conditions_paiement text,
  lignes           jsonb   default '[]',
  created_at       timestamptz default now(),
  updated_at       timestamptz default now()
);

-- TABLE INVENTAIRE
create table if not exists inventory (
  id           uuid    default gen_random_uuid() primary key,
  user_id      uuid    references auth.users(id) on delete cascade not null,
  designation  text    not null,
  ref          text,
  unit         text    default 'u',
  price        numeric(10,2) default 0,
  tva          integer default 20,
  qty          numeric(10,2) default 0,
  seuil        numeric(10,2) default 0,
  created_at   timestamptz default now(),
  updated_at   timestamptz default now()
);

-- TABLE RAPPELS
create table if not exists rappels (
  id           uuid    default gen_random_uuid() primary key,
  user_id      uuid    references auth.users(id) on delete cascade not null,
  client_nom   text,
  devis_num    text,
  note         text,
  scheduled_at timestamptz,
  done         boolean default false,
  created_at   timestamptz default now()
);

-- TABLE DÉPENSES
create table if not exists depenses (
  id           uuid    default gen_random_uuid() primary key,
  user_id      uuid    references auth.users(id) on delete cascade not null,
  categorie    text    default 'autre',
  description  text,
  montant      numeric(10,2) default 0,
  tva_rate     integer default 20,
  date_depense date    default current_date,
  created_at   timestamptz default now()
);

-- TABLE AVIS
create table if not exists avis_clients (
  id         uuid    default gen_random_uuid() primary key,
  user_id    uuid    references auth.users(id) on delete cascade not null,
  name       text,
  city       text,
  service    text,
  stars      integer default 5,
  content    text,
  avis_date  text,
  published  boolean default true,
  created_at timestamptz default now()
);

-- ================================================================
-- ROW LEVEL SECURITY (RLS) — seul David voit ses données
-- ================================================================
alter table devis          enable row level security;
alter table inventory      enable row level security;
alter table rappels        enable row level security;
alter table depenses       enable row level security;
alter table avis_clients   enable row level security;

-- Policies
create policy "own_devis"      on devis          for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own_inventory"  on inventory      for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own_rappels"    on rappels        for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own_depenses"   on depenses       for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own_avis"       on avis_clients   for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ================================================================
-- TRIGGER updated_at automatique
-- ================================================================
create or replace function set_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at = now(); return new; end; $$;

create trigger devis_updated_at     before update on devis     for each row execute function set_updated_at();
create trigger inventory_updated_at before update on inventory for each row execute function set_updated_at();
