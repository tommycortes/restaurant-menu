with Ada.Text_IO;use Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package body dtrie is

   mk: constant key_component:= key_component'First;
   lastc: constant key_component:= key_component'Last;
   i0: constant key_index:= key_index'First;
   
   procedure t_empty(t: out trie) is
   begin
      t.root:= new cell(INTERIOR);
      t.root.ti:= (others => null);
   end t_empty;
   
   function t_exists(t: in trie; k: in key) return boolean is
      p: pcell;
      i: key_index;
      c: key_component;
      
   begin
      p:= t.root; i:= i0; c:= k(i);
      while c /= mk and p.ti(c) /= null loop
         p:= p.ti(c); i:= i+1; c:= k(i);
      end loop;
      
      return c = mk and p.ti(mk) /= null; --hacer que sea != null, ya no es un autopuntero
   end t_exists;
   
   procedure t_put(t: in out trie; k: in key; x: in elem) is
      p, r: pcell;
      i: key_index;
      c: key_component;
   begin
      p:= t.root; i:= i0; c:= k(i);
      while c/= mk loop
         if p.ti(c) = null then
            r:= new cell(INTERIOR);
            r.ti:= (others => null);
            p.ti(c):= r;
         end if;
         p:= p.ti(c); i:= i+1; c:= k(i);
      end loop;
      r:= new cell(LEAF);
      r.tc:= x;
      p.ti(mk):= r;
      
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
            if p.ti(c)/= null then nd:= nd+1; end if;
            c:= key_component'Succ(c);
         end loop;
         if p.ti(c)/= null then nd:= nd +1; end if;
         return nd<2;
      end only_desc;
      
   begin
      p:= t.root; i:= i0; c:= k(i); r:= p; cr:= c;
      while c/= mk and p.ti(c)/= null loop
         if not only_desc(p) then r:= p; cr:= c; end if;
         p:= p.ti(c); i:= i+1; c:= k(i);
      end loop;
      if c = mk and p.ti(mk) /= null then
         if only_desc(p) then
            r.ti(cr):= null;
         else p.ti(mk):= null;
         end if;
      end if;
   end t_delete;
   
   function t_is_empty(t: in trie) return boolean is
   begin
      return t.root = null;
   end t_is_empty;
   
   procedure t_get(t: in trie; k: in key; x: out  elem) is
      p: pcell;
      i: key_index;
      c: key_component;
   begin
      p:= t.root; i:= i0; c:= k(i);
      while c/= mk and p.ti(c)/= null loop
         p:= p.ti(c); i:= i+1; c:= k(i);
      end loop;
      
      if p.ti(c) = null then raise elem_does_not_exist; end if;
      
      x:= p.ti(mk).tc;
      
   end t_get;
   
   procedure firstbranch(p: in pcell; c: out key_component; found: out boolean) is 
   begin
      c := mk; found := (p.ti(c) /= null);
      while c < lastc and not found loop
         c := key_component'Succ(c);
         found := (p.ti(c) /= null);
      end loop;          
   end firstbranch;

   procedure i_first(t: in trie; it: out iterator) is
      root: pcell renames t.root;
      pth: path renames it.pth;
      k: key renames it.k;
      i: key_index renames it.i;
      c: key_component;
      p: pcell;
      found: boolean;
   begin
      p := root; i:= i0;
      firstbranch(p, c, found);
      while found and c/=mk loop
         pth(i):= p; k(i):= c; i:= i+1;
         p:= p.ti(c);
         firstbranch(p, c, found);
      end loop;
      pth(i):= p; k(i):= mk;
   end i_first;
   
   procedure nextbranch(p: in pcell; c: in out key_component; found: out boolean) is
   begin
      found := false;
      while c<lastc and not found loop
         c := key_component'Succ(c);
         found := (p.ti(c) /= null);
      end loop;
   end nextbranch;
   
   procedure i_next(t: in trie; it: in out iterator) is
      root: pcell renames t.root;
      pth: path renames it.pth;
      k: key renames it.k;
      i: key_index renames it.i;
      c: key_component;
      p: pcell;
      found: boolean;
   begin
      if k(i0)=mk then raise bad_use; end if;
      p:= pth(i); c:= k(i);
      nextbranch(p, c, found);
      while not found and i>1 loop
         i:= i-1; p:= pth(i); c:= k(i);
         nextbranch(p, c, found);
      end loop;
      while found and c/=mk loop 
         pth(i) := p; k(i) := c; i := i+1;
         p:= p.ti(c);
         firstbranch(p, c, found);
      end loop;
      pth(i) := p; k(i) := mk;
   end i_next;
   
   function i_is_valid(it: in iterator) return boolean is
      k: key renames it.k;
   begin
      return k(i0)/=mk;
   end i_is_valid;
   
   procedure i_get(t: in trie; it: in iterator; k: out key) is      
   begin
      if it.k(i0)=mk then raise bad_use; end if;
      k:= it.k;
   end i_get;
   
   
end dtrie;
