function F = integral(f, t, r, a, b)
    syms t


    integrand = f * t;
    F = int(integrand, r, a, b);

    
end