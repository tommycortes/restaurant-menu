with ada.Text_IO; use Ada.Text_IO;

package body dmenu is
   procedure m_empty(m: out menu) is
   begin
      for i in tcategory'First .. tcategory'Last loop
         t_empty(m(i));
      end loop;
      
   end m_empty;
   
   procedure m_put(m: in out menu; cat: in tcategory; k: in tkey; name: in Unbounded_String) is
      t: trie;
      c: pcourse;
      comm: comment_queue_array;
   begin
      c := new course;
      c.name := name;
      c.comments := comm;
      t_put(m(cat), k, c);
   end m_put;
   
   procedure m_print(m: in menu; cat: in tcategory) is
      c: pcourse;
      it: iterator;
      k: tkey;
   begin
      i_first(m(cat), it);
      while i_is_valid(it) loop
         i_get(m(cat), it, k);
         t_get(m(cat), k, c);
         
         if c /= null then
            Put_Line(c.name);
         end if;
         i_next(m(cat), it);
      end loop;
   end m_print;
   
   procedure m_delete_element(m: in out menu; cat: in tcategory; k: in tkey) is
   begin
      t_delete(m(cat), k);
   end m_delete_element;
   
   procedure m_put_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification; comment: in Unbounded_String) is
      co: pcourse;
   begin
      t_get(m(cat), k, co);
      add(co.comments(c), comment);
   end m_put_comment;
   
   function m_read_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) return Unbounded_String is
      u: Unbounded_String;
      co: pcourse;
   begin
      t_get(m(cat), k, co);
      return get_first(co.comments(c));
   end m_read_comment;
   
   function m_exists_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) return Boolean is
      co: pcourse;
   begin
      t_get(m(cat), k, co);
      return not is_empty(co.comments(c));
   end m_exists_comment;
   
   procedure m_delete_comment(m: in out menu; cat: in tcategory; k: in tkey; c: in tcalification) is
      co: pcourse;
   begin
      t_get(m(cat), k, co);
      delete_first(co.comments(c));
   end m_delete_comment;
     
end dmenu;
