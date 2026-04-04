/**
 * ================================================================
 * CONFIGURATION SUPABASE — SIB.Elec
 * ================================================================
 *
 * ÉTAPES D'INSTALLATION :
 * 1. Créez un compte gratuit sur https://supabase.com
 * 2. Créez un nouveau projet (région : Europe West)
 * 3. Dans Settings > API, copiez :
 *    - "Project URL" → remplacez SUPABASE_URL ci-dessous
 *    - "anon / public" key → remplacez SUPABASE_ANON_KEY ci-dessous
 * 4. Dans le SQL Editor de Supabase, exécutez le contenu de setup-supabase.sql
 * 5. Dans Authentication > Users, créez le compte de David :
 *    email: siboutrenov@gmail.com  |  mot de passe: [choisissez un mot de passe fort]
 * 6. Sauvegardez ce fichier — le dashboard se connectera automatiquement
 *
 * IMPORTANT: Ne partagez jamais ce fichier publiquement.
 * ================================================================
 */

const SUPABASE_URL      = 'VOTRE_URL_ICI';         // ex: https://abcdefgh.supabase.co
const SUPABASE_ANON_KEY = 'VOTRE_CLE_ANON_ICI';    // ex: eyJhbGciOiJIUzI1NiIsInR5cCI6...

// Ne pas modifier cette ligne
window.SIBELEC_SUPABASE = { url: SUPABASE_URL, key: SUPABASE_ANON_KEY };
