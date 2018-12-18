function init()

end

function update(dt)
  buff = effect.getParameter("buff")

  status.addEphemeralEffect(buff, 5)
end

function uninit()
end
