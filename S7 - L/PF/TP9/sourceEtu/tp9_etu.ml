
module GreenThreads =
  struct
    (* à compléter/modifier *)
      type res = 
      | Fork of ((unit -> unit) * (unit -> res))
      | Yield of (unit -> res)
      | Done

    let prompt0 = Delimcc.new_prompt ()

    let scheduler proc_init = 
      let queue = Queue.create () in
      let rec handle result =
          match result with
          | Done -> if Queue.is_empty queue then () 
            else let k = Queue.pop queue in handle (k ())
          | Yield k -> Queue.push k queue; let k' = Queue.pop queue in handle (k' ())
          | Fork (proc,k) -> Queue.push k queue; run proc
      and run prog =
        handle (Delimcc.push_prompt prompt0 (fun () -> prog (); Done))
      in run proc_init

    let yield () = Delimcc.shift prompt0 (fun k -> Yield k)
    let fork proc = Delimcc.shift prompt0 (fun k -> Fork (proc,k))
    let exit () = Delimcc.shift prompt0 (fun _ -> Done)
  end

  let rec ping n =
    GreenThreads.(if n = 0 then exit ()
    else (print_string "ping! \n"; yield (); ping (n-1)))
  
  let rec pong n =
    GreenThreads.(if n = 0 then exit ()
    else (print_string "pong! \n"; yield (); ping (n-1)))
  
  let ping_pong = GreenThreads.(fork (ping 10); fork (pong 10); exit ())

  let main = GreenThreads.scheduler ping_pong

module type Channel =
  sig
    val create : unit -> ('a -> unit) * (unit -> 'a)
  end

module GTChannel : Channel =
  struct
    (* à compléter/modifier *)
    let create () = assert false
  end
    
let sieve () =
  let rec filter reader =
    GreenThreads.(
      let v0 = reader () in
      if v0 = -1 then exit () else
      Format.printf "%d@." v0;
      yield ();
      let (writer', reader') = GTChannel.create () in
      fork (fun () -> filter reader');
      while true
      do
        let v = reader () in
        yield ();
        if v mod v0 <> 0 then writer' v;
        if v = -1 then exit ()
      done
    ) in
  let main () =
    GreenThreads.(
      let (writer, reader) = GTChannel.create () in
      fork (fun () -> filter reader);
      for i = 2 to 1000
      do
        writer i;
        yield ()
      done;
      writer (-1);
      exit ()
    ) in
  GreenThreads.scheduler main
