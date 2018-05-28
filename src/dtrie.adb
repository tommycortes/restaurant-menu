package body dtrie is

   mk: constant key_component:= key_component'First;
   lastc: constant key_component:= key_component'Last;
   i0: constant key_index:= key_index'First;
   
   procedure t_empty(t: out trie) is
   begin
      t.root:= new cell;
      t.root.all:= (others => null);
   end t_empty;
   
   function exists(t: in trie; k: in key) return boolean is
      p: pcell;
      i: key_index;
      c: key_component;
      
   begin
      p:= t.root; i:= i0; c:= k(i);
      while c /= mk and p.all(c) /= null loop
         
end dtrie;
