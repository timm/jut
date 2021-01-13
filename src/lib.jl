# vim: set et ts=2 sw=2:

# A file of miscellaneous utilities.
# ## Meta
same(s) = s        

# ## Maths
# `int`: Round numbers   
# `any,few`: Pull one or `n` things from a list (at random) 
int(x)  = floor(Int,x)
any(a)  = a[ int(length(a) * rand()) + 1]
few(a,n=it.divs.few)=length(a)<n ? a : [any(a) for _ in 1:n]

# ## Strings
# `thing`: coerce things to floats or strings   
# `say,sayln`: print a struct, maybe with a trailing new line.
thing(x) = try parse(Float64,x) catch _ x end

sayln(i) = begin ay(i); println("") end

function say(i)
  s,pre="$(typeof(i)){",""
  for f in sort!([x for x in fieldnames(typeof(i)) 
                 if !("$x"[1] == '_')])
    g = getfield(i,f)
    s = s * pre * "$f=$g"
    pre=", " end
  print(s * "}") end

# ## Files
# `csv`: interate over a fiile
@resumable function csv(file;zap=r"(\s+|#.*)")
  b4=""
  for line in eachline(file)
    line = replace(line,zap =>"")
    if length(line) != 0
      if line[end] == ',' # if line ends with ",",
        b4 = b4 * line    # join it to next
      else
        @yield [thing(x) for x in split(b4*line,",")]
                b4 = "" end end end end  
