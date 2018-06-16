with Ada.Text_IO; use Ada.Text_IO;
with darray_enum;

procedure Restaurant is

   type FOOD_CLASS is (STARTER, FIRST);

   package FoodClassArray is new darray_enum(item => Character, key => FOOD_CLASS); use FoodClassArray;

   my_array: array_enum;

   char1, char2: Character;

begin

   --a_empty(my_array, 'X');
   a_put(my_array, STARTER, 'S');
   a_put(my_array, FIRST, 'O');

   a_get(my_array, STARTER, char1);
   a_get(my_array, FIRST, char2);

   Put(char1);
   Put(char2);

end Restaurant;
