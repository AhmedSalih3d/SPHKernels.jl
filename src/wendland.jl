
"""
    struct WendlandC4 <: SPHKernel
        n_neighbours::Int64
        norm_2D::Float64
        norm_3D::Float64
        function WendlandC4(n_neighbours::Int64=216)
            new(n_neighbours,9.0/π, 495.0/(32.0 * π))
        end
    end
"""
struct WendlandC4 <: SPHKernel
    n_neighbours::Int64
    norm_2D::Float64
    norm_3D::Float64
    function WendlandC4(n_neighbours::Integer=216)
        new(n_neighbours, 9.0/π, 495.0/(32.0 * π))
    end
end

"""
    kernel_value_2D(kernel::WendlandC4, u::Real, h_inv::Real)

Evaluate WendlandC4 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_value_2D(kernel::WendlandC4, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^2
        u_m1 = 1.0 - u
        u_m1_5 = u_m1*u_m1*u_m1*u_m1*u_m1
        return ( u_m1 * u_m1_5 * ( 1.0 + 6u + 35.0/3.0 * u^2 ) ) * n
    else
        return 0.
    end

end

"""
    kernel_deriv_2D(kernel::WendlandC4, u::Real, h_inv::Real)

Evaluate the derivative of the WendlandC4 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_deriv_2D(kernel::WendlandC4, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^3
        u_m1 = 1.0 - u
        u_m1_5 = u_m1*u_m1*u_m1*u_m1*u_m1
        return ( -288.0/3.0 * u_m1_5 * u^2 - 56.0/3.0 * u * u_m1_5 ) * n
    else
        return 0.
    end

end

""" 
    bias_correction_2D(kernel::WendlandC4, density::Real, m::Real, h_inv::Real)

Corrects the density estimate for the kernel bias. See Dehnen&Aly 2012, eq. 18+19.
"""
@inline function bias_correction_2D(kernel::WendlandC4, density::Real, m::Real, h_inv::Real)

    @fastmath n = kernel.norm_2D * h_inv^3
    @fastmath wc_correction = 0.01342 * ( kernel.n_neighbours * 0.01 )^(-1.579) * m * n
    
    return density - wc_correction
end


"""
    kernel_value_3D(kernel::WendlandC4, u::Real, h_inv::Real)

Evaluate WendlandC4 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_value_3D(kernel::WendlandC4, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_3D * h_inv^2
        u_m1 = 1.0 - u
        u_m1_5 = u_m1*u_m1*u_m1*u_m1*u_m1
        return ( u_m1 * u_m1_5 * ( 1.0 + 6u + 35.0/3.0 * u^2 ) ) * n
    else
        return 0.
    end

end

"""
    kernel_deriv_3D(kernel::WendlandC4, u::Real, h_inv::Real)

Evaluate the derivative of the WendlandC4 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_deriv_3D(kernel::WendlandC4, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_3D * h_inv^3
        u_m1 = 1.0 - u
        u_m1_5 = u_m1*u_m1*u_m1*u_m1*u_m1
        return ( -288.0/3.0 * u_m1_5 * u^2 - 56.0/3.0 * u * u_m1_5 ) * n
    else
        return 0.
    end

end

""" 
    bias_correction_3D(kernel::WendlandC4, density::Real, m::Real, h_inv::Real)

Corrects the density estimate for the kernel bias. See Dehnen&Aly 2012, eq. 18+19.
"""
@inline function bias_correction_3D(kernel::WendlandC4, density::Real, m::Real, h_inv::Real)

    @fastmath n = kernel.norm_3D * h_inv^3
    @fastmath wc_correction = 0.01342 * ( kernel.n_neighbours * 0.01 )^(-1.579) * m * n
    
    return density - wc_correction
end


"""
    struct WendlandC6 <: SPHKernel
        n_neighbours::Int64
        norm_2D::Float64
        norm_3D::Float64
        function WendlandC6(n_neighbours::Int64=295)
            new(n_neighbours, 78.0/(7.0*π), 1365.0/(64.0*π))
        end
    end
"""
struct WendlandC6 <: SPHKernel
    n_neighbours::Int64
    norm_2D::Float64
    norm_3D::Float64
    function WendlandC6(n_neighbours::Integer=295)
        new(n_neighbours, 78.0/(7.0*π), 1365.0/(64.0*π))
    end
end

"""
    kernel_value_2D(kernel::WendlandC6, u::Real, h_inv::Real)

Evaluate WendlandC6 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_value_2D(kernel::WendlandC6, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^2
        u_m1 = (1.0 - u)
        u_m1 = u_m1 * u_m1  # (1.0 - u)^2
        u_m1 = u_m1 * u_m1  # (1.0 - u)^4
        u_m1 = u_m1 * u_m1  # (1.0 - u)^8
        u2 = u*u
        return ( u_m1 * ( 1.0 + 8u + 25u2 + 32u2*u )) * n
    else
        return 0.0
    end

end

"""
    kernel_deriv_2D(kernel::WendlandC6, u::Real, h_inv::Real)

Evaluate the derivative of the WendlandC6 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_deriv_2D(kernel::WendlandC6, u::Real, h_inv::Real)


    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^3
        u_m1 = 1.0 - u
        u_m1_7 = u_m1 * u_m1 * u_m1 * u_m1 * u_m1 * u_m1 * u_m1
        return ( -22u_m1_7 * u * ( 16u^2 + 7u + 1.0 )) * n
    else
        return 0.0
    end

end

""" 
    bias_correction_2D(kernel::WendlandC6, density::Real, m::Real, h_inv::Real)

Corrects the density estimate for the kernel bias. See Dehnen&Aly 2012, eq. 18+19.
"""
@inline function bias_correction_2D(kernel::WendlandC6, density::Real, m::Real, h_inv::Real)

    @fastmath n = kernel.norm_2D * h_inv^3
    @fastmath wc_correction = 0.0116 * ( kernel.n_neighbours * 0.01 )^(-2.236) * m * n

    if wc_correction < 0.2*density
        density -= wc_correction
    end
    
    return density
end


"""
    kernel_value_3D(kernel::WendlandC6, u::Real, h_inv::Real)

Evaluate WendlandC6 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_value_3D(kernel::WendlandC6, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_3D * h_inv^3
        u_m1 = 1.0 - u
        u_m1 = u_m1 * u_m1  # (1.0 - u)^2
        u_m1 = u_m1 * u_m1  # (1.0 - u)^4
        u_m1 = u_m1 * u_m1  # (1.0 - u)^8
        u2 = u*u
        return ( u_m1 * ( 1.0 + 8u + 25u2 + 32u2*u )) * n
    else
        return 0.0
    end

end

"""
    kernel_deriv_3D(kernel::WendlandC6, u::Real, h_inv::Real)

Evaluate the derivative of the WendlandC6 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_deriv_3D(kernel::WendlandC6, u::Real, h_inv::Real)


    @fastmath if u < 1.0
        n = kernel.norm_3D * h_inv^4
        u_m1 = 1.0 - u
        u_m1_7 = u_m1 * u_m1 * u_m1 * u_m1 * u_m1 * u_m1 * u_m1
        return ( -22u_m1_7 * u * ( 16u^2 + 7u + 1.0 )) * n
    else
        return 0.0
    end

end


""" 
    bias_correction_3D(kernel::WendlandC6, density::Real, m::Real, h_inv::Real)

Corrects the density estimate for the kernel bias. See Dehnen&Aly 2012, eq. 18+19.
"""
@inline function bias_correction_3D(kernel::WendlandC6, density::Real, m::Real, h_inv::Real)

    @fastmath n = kernel.norm_3D * h_inv^3
    @fastmath wc_correction = 0.0116 * ( kernel.n_neighbours * 0.01 )^(-2.236) * m * n

    if wc_correction < 0.2*density
        density -= wc_correction
    end
    
    return density
end




"""
    struct WendlandC8 <: SPHKernel
        n_neighbours::Int64
        norm_2D::Float64
        norm_3D::Float64
        function WendlandC6(n_neighbours::Integer=395)
            new(n_neighbours, 8.0/(3π), 357.0/(64π))
        end
    end
"""
struct WendlandC8 <: SPHKernel
    n_neighbours::Int64
    norm_2D::Float64
    norm_3D::Float64
    function WendlandC8(n_neighbours::Integer=395)
        new(n_neighbours, 8.0/(3π), 357.0/(64π))
    end
end

"""
    kernel_value_2D(kernel::WendlandC8, u::Real, h_inv::Real)

Evaluate WendlandC6 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_value_2D(kernel::WendlandC8, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^2
        t1 = (1.0 - u)
        t9 = t1*t1*t1*t1*t1*t1*t1*t1*t1  # (1.0 - u)^9
        u2 = u*u
        return ( t1 * t9 * (5.0 + 50u + 210u2 + 450u2 * u + 429u2 * u2)) * n
    else
        return 0.0
    end

end

"""
    kernel_deriv_2D(kernel::WendlandC8, u::Real, h_inv::Real)

Evaluate the derivative of the WendlandC6 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_deriv_2D(kernel::WendlandC8, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^2
        t1 = (1.0 - u)
        t9 = t1*t1*t1*t1*t1*t1*t1*t1*t1  # (1.0 - u)^9
        u2 = u*u
        return -26t9 * u * (231u2 * u + 159u2 + 45u + 5.0) * n
    else
        return 0.0
    end

end

""" 
    bias_correction_2D(kernel::WendlandC8, density::Real, m::Real, h_inv::Real)

Corrects the density estimate for the kernel bias. See Dehnen&Aly 2012, eq. 18+19.
"""
@inline function bias_correction_2D(kernel::WendlandC8, density::Real, m::Real, h_inv::Real)

    return density
end


"""
    kernel_value_3D(kernel::WendlandC8, u::Real, h_inv::Real)

Evaluate WendlandC8 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_value_3D(kernel::WendlandC8, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^2
        t1 = (1.0 - u)
        t9 = t1*t1*t1*t1*t1*t1*t1*t1*t1  # (1.0 - u)^9
        u2 = u*u
        return ( t1 * t9 * (5.0 + 50u + 210u2 + 450u2 * u + 429u2 * u2)) * n
    else
        return 0.0
    end

end

"""
    kernel_deriv_3D(kernel::WendlandC8, u::Real, h_inv::Real)

Evaluate the derivative of the WendlandC8 spline at position ``u = \\frac{x}{h}``.
"""
@inline function kernel_deriv_3D(kernel::WendlandC8, u::Real, h_inv::Real)

    @fastmath if u < 1.0
        n = kernel.norm_2D * h_inv^2
        t1 = (1.0 - u)
        t9 = t1*t1*t1*t1*t1*t1*t1*t1*t1  # (1.0 - u)^9
        u2 = u*u
        return -26t9 * u * (231u2 * u + 159u2 + 45u + 5.0) * n
    else
        return 0.0
    end

end


""" 
    bias_correction_3D(kernel::WendlandC8, density::Real, m::Real, h_inv::Real)

Corrects the density estimate for the kernel bias. See Dehnen&Aly 2012, eq. 18+19.
"""
@inline function bias_correction_3D(kernel::WendlandC8, density::Real, m::Real, h_inv::Real)
    return density
end
