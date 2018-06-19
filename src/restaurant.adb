with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with dmenu;

procedure Restaurant is
   package mimenu is new dmenu(Integer);
   use mimenu;
   my_menu: menu;

   key: tkey;
begin

   key(0) := 'A';
   key(1) := '@';
   m_put(my_menu, STARTER, key, To_Unbounded_String("mierda"));
   m_delete_element(my_menu, STARTER, key);
end Restaurant;
