function zeta = Hurwitz_zeta(alpha, xmin)

numx = 100000;
for ii = 1:length(xmin)
    terms = xmin(ii):xmin(ii)+numx;
    zeta(ii) = sum ( terms.^(-alpha) );
end