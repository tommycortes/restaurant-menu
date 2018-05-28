package body dqueue_pointers is

   procedure empty(q: out queue) is
   begin
      
      q.first := null; q.last := null;
      
   end empty;
   
   procedure add(q: in out queue; x: in elem) is
      
      new_cell: pcell;
      
   begin
      
      new_cell := new cell'(x, null);
      
      --empty queue
      if q.first = null then
         q.first := new_cell;
         q.last := new_cell;
      end if;
      
      q.last.next := new_cell;
      q.last := new_cell;
      
   exception
         when Storage_Error => raise overflow;
      
   end add;
   
   procedure delete_first(q: in out queue) is
   begin
      
      if q.first /= null then
         q.first := q.first.next;
      else
         q.last := null;
      end if;
      
   end delete_first;
   
   function get_first(q: in queue) return elem is
   begin
      
      return q.first.e;
      
   end get_first;
   
   function is_empty(q: in queue) return boolean is
   begin
      
      return q.first = null;
      
   end is_empty;
   
   function is_last_item(q: in queue) return boolean is
   begin
      
      return q.first.next = null;
      
   exception
      when Constraint_Error => raise bad_use;
         
   end is_last_item;
   
   
end dqueue_pointers;
