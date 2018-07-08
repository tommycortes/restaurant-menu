with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with dmenu; use dmenu;

procedure Restaurant is
   my_menu: menu;
   u: Unbounded_String;
begin

   --FALL/WINTER
   Put_Line("---------FALL/WINTER MENU---------");
   m_empty(my_menu);
   m_put(my_menu, STARTER, "LGT@", To_Unbounded_String("plato LGT"));
   m_put(my_menu, STARTER, "XYZ@", To_Unbounded_String("plato XYZ"));
   m_put(my_menu, STARTER, "WEB@", To_Unbounded_String("plato WEB"));
   m_put(my_menu, MAIN, "ZCW@", To_Unbounded_String("plato ZCW"));
   m_put(my_menu, MAIN, "BMW@", To_Unbounded_String("plato BMW"));
   m_put(my_menu, MAIN, "WWW@", To_Unbounded_String("plato WWW"));
   m_put(my_menu, SECOND, "XRM@", To_Unbounded_String("plato XRM"));
   m_put(my_menu, SECOND, "CMY@", To_Unbounded_String("plato CMY"));
   m_put(my_menu, SECOND, "TAD@", To_Unbounded_String("plato TAD"));
   m_put(my_menu, DESSERT, "BCF@", To_Unbounded_String("plato BCF"));
   m_put(my_menu, DESSERT, "BCC@", To_Unbounded_String("plato BCC"));
   m_put(my_menu, DESSERT, "TDD@", To_Unbounded_String("plato TDD"));
   m_put(my_menu, DRINK, "JGS@", To_Unbounded_String("plato JGS"));
   m_put(my_menu, DRINK, "RBR@", To_Unbounded_String("plato RBR"));
   m_put(my_menu, DRINK, "SHA@", To_Unbounded_String("plato SHA"));

   for i in tcategory'Range loop
      Put(i'Image & " CATEGORY"); New_Line(1);
      m_print(my_menu, i); New_Line(1);
   end loop;

   --removing courses
   m_delete_element(my_menu, DESSERT, "BCF@");
   m_delete_element(my_menu, DRINK, "RBR@");
   m_delete_element(my_menu, STARTER, "LGT@");
   Put_Line("Borramos los platos BCF, RBR y LGT");

   --SPRING/SUMMER
   Put_Line("---------SPRING/SUMMER MENU---------");
   --adding new courses
   m_put(my_menu, STARTER, "CSS@", To_Unbounded_String("plato CSS"));
   m_put(my_menu, MAIN, "PHP@", To_Unbounded_String("plato PHP"));
   m_put(my_menu, SECOND, "FTP@", To_Unbounded_String("plato FTP"));
   m_put(my_menu, SECOND, "ULM@", To_Unbounded_String("plato ULM"));
   m_put(my_menu, DESSERT, "URL@", To_Unbounded_String("plato URL"));
   m_put(my_menu, DRINK, "RLC@", To_Unbounded_String("plato RLC"));

   for i in tcategory'Range loop
      Put(i'Image & " CATEGORY"); New_Line(1);
      m_print(my_menu, i); New_Line(1);
   end loop;

   --COMMENTS
   Put_Line("---------COMMENTS---------");
   m_put_comment(my_menu, STARTER, "CSS@", BAD, To_Unbounded_String("Me gusta más con SASS"));
   m_put_comment(my_menu, STARTER, "CSS@", GREAT, To_Unbounded_String("Es una delicia"));
   m_put_comment(my_menu, STARTER, "CSS@", GREAT, To_Unbounded_String("Hmmmm!"));
   m_put_comment(my_menu, STARTER, "CSS@", GOOD, To_Unbounded_String("Los he probado peores pero tambien mejores"));

   if m_exists_comment(my_menu, STARTER, "CSS@", GREAT) then
      u := m_read_comment(my_menu, STARTER, "CSS@", GREAT);
      Put_Line("Comentaio GREAT: " & u);
   end if;

   m_delete_comment(my_menu, STARTER, "CSS@", GREAT);
   Put_Line("Borramos comentario GREAT");

   if m_exists_comment(my_menu, STARTER, "CSS@", GREAT) then
      u := m_read_comment(my_menu, STARTER, "CSS@", GREAT);
      Put_Line("Siguiente comentario GREAT: " & u);
   end if;

end Restaurant;
