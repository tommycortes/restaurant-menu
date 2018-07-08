with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with dmenu;

procedure Restaurant is
   package mimenu is new dmenu(Integer);
   use mimenu;
   my_menu: menu;

   key: tkey;

   type class is(ENTR, PRIME);
   type comida is array(class) of Integer;
   c: comida;
begin

   c(ENTR) := 1;


   key(1..3) := 'A';
   key(1) := '@';
   m_put(my_menu, STARTER, key, To_Unbounded_String("hola"));
   m_delete_element(my_menu, STARTER, key);
end Restaurant;
