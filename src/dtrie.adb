package body dtrie is

   mk: constant key_component:= key_component'First;
   lastc: constant key_component:= key_component'Last;
   i0: constant key_index:= key_index'First;
   
   procedure t_empty(t: out trie) is
   begin
      t.root:= new cell;
      t.root.all:= (others => null);
   end t_empty;
   
   function t_exists(t: in trie; k: in key) return boolean is
      p: pcell;
      i: key_index;
      c: key_component;
      
   begin
      p:= t.root; i:= i0; c:= k(i);
      while c /= mk and p.all(c) /= null loop
         p:= p.all(c); i:= i+1; c:= k(i);
      end loop;
      
      return c = mk and p.all(mk) = p;
   end t_exists;
   
   procedure t_put(t: in out trie; k: in key) is
      p, r: pcell;
      i: key_index;
      c: key_component;
   begin
      p:= t.root; i:= i0; c:= k(i);
      while c/= mk loop
         if p.all(c) = null then
            r:= new cell;
            r.all:= (others => null);
            p.all(c):= r;
         end if;
         p:= p.all(c); i:= i+1; c:= k(i);
      end loop;
      p.all(mk):= p;
   exception
      when Storage_Error => raise overflow;
   end t_put;
   
   procedure t_delete(t: in out trie; k: in key) is
      p, r: pcell;
      i: key_index;
      c, cr: key_component;
      function only_desc(p: in pcell) return boolean is
         c: key_component;
         nd: Integer;
      begin
         c:= mk; nd:= 0;
         while c/= lastc and nd<2 loop
            if p.all(c)/= null then nd:= nd+1; end if;
            c:= key_component'Succ(c);
         end loop;
         if p.all(c)/= null then nd:= nd +1; end if;
         return nd<2;
      end only_desc;
      
   begin
      p:= t.root; i:= i0; c:= k(i); r:= p; cr:= c;
      while c/= mk and p.all(c)/= null loop
         if not only_desc(p) then r:= p; cr:= c; end if;
         p:= p.all(c); i:= i+1; c:= k(i);
      end loop;
      if c = mk and p.all(mk) = p then
         if only_desc(p) then
            r.all(cr):= null;
         else p.all(mk):= null;
         end if;
      end if;
   end t_delete;
   
   function t_is_empty(t: in trie) return boolean is
   begin
      return t.root = null;
   end t_is_empty;
   
end dtrie;
