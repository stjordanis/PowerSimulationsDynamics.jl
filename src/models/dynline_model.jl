function mdl_line_ode!(
    device_states,
    output_ode,
    V_r_from,
    V_i_from,
    V_r_to,
    V_i_to,
    current_r_from,
    current_i_from,
    current_r_to,
    current_i_to,
    sys_f,
    branch::PSY.DynamicBranch,
)
    L = PSY.get_x(branch)
    R = PSY.get_r(branch)
    ω_b = sys_f * 2 * π

    Il_r = device_states[1]
    Il_i = device_states[2]
    output_ode[1] = (ω_b / L) * ((V_r_from[1] - V_r_to[1]) - (R * Il_r - L * Il_i))
    output_ode[2] = (ω_b / L) * ((V_i_from[1] - V_i_to[1]) - (R * Il_i + L * Il_r))

    current_r_from[1] -= Il_r
    current_i_from[1] -= Il_i
    current_r_to[1] += Il_r
    current_i_to[1] += Il_i
end
