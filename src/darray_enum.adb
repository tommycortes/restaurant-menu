package body darray_enum is
   
   --when trie implementation is done, quit item and assign with null
   procedure a_empty(a: out array_enum; x: in item) is
   begin
      
      for i in a.values'Range loop
         a.values(i) := x;
      end loop;
      
   end a_empty;
   
   procedure a_get(a: in array_enum; k: in key; x: out item) is
   begin
      
      x := a.values(k);
      
   end a_get;
   
   procedure a_put(a: in out array_enum; k: in key; x: in item) is
   begin
      
      a.values(k) := x;
      
   end a_put;
   
   procedure a_remove(a: in out array_enum; k: in key) is
   begin
      a.values(k) := null;
   
end darray_enum;
