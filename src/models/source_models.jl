function mdl_source!(
    voltage_r,
    voltage_i,
    current_r,
    current_i,
    device::PSY.Source,
    sys::PSY.System,
)

    #Load device parameters
    V = PSY.get_voltage(PSY.get_bus(device))
    angle = PSY.get_angle(PSY.get_bus(device))
    X_th = PSY.get_X_th(device)

    #I = ( (V_R + V_I*1im) - (V_tR + V_tI*1im) )/(X_th*1im)
    #I_r = (V_I - V_tI)/X_th #in system pu flowing out
    #I_i = -(V_R - V_tR)/X_th #in system pu flowing out

    #update current
    current_r[1] += (V*sin(angle) - voltage_i[1]) / X_th #in system pu flowing out
    current_i[1] += -(V*cos(angle) - voltage_r[1]) / X_th #in system pu flowing out

    return
end
