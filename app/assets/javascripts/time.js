$("time").each((i, el)=>{
  const current=$(el).attr("datetime");
  $(el).filter(".date").text(moment(current).format("MMM Do"));
  $(el).filter(".time").text(moment(current).format("HH:mm"));
});
