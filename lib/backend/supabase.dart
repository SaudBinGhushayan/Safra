import 'package:supabase/supabase.dart';

const supabaseUrl = 'https://veeiwquigtcerblxmomx.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZlZWl3cXVpZ3RjZXJibHhtb214Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjQ4MTY1NDEsImV4cCI6MTk4MDM5MjU0MX0.SMy1hOB8OmNbUqruiEn3tD30ee0IzC5x0hcVHpYNEnU';

class SupaBase_Manager {
  final client = SupabaseClient(supabaseUrl, supabaseKey);
}
