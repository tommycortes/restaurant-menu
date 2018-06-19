generic
   type item is private;
   type key is (<>);
package darray_enum is
   
   type array_enum is private;
   
   --the item is to fill every position in the array, until trie implementation is done.
   procedure a_empty(a: out array_enum);
   procedure a_get(a: in array_enum; k: in key; x: out item);
   procedure a_put(a: in out array_enum; k: in key; x: in item);
   --procedure a_remove(a: in out array_enum; k: in key);
   
private
   
   type item_array is array(key range key'First .. key'Last) of item;
   
   type array_enum is record
      values: item_array;
   end record;

end darray_enum;
