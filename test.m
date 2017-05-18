npt = 1000000;
xrange = linspace(-10,10,npt);

tpdf = 1;

if tpdf == 1
    yrange= normpdf(xrange,sg.gauss.g1.mu,sg.gauss.g1.std);
    dados = DATA.sg(tpdf,:);
elseif tpdf == 2
    yrange = (normpdf(xrange,sg.normal.g1.mu,sg.normal.g1.std) + normpdf(xrange,sg.normal.g2.mu,sg.normal.g2.std))/2;
dados = DATA.sg(tpdf,:);
elseif tpdf == 3
    yrange  = raylpdf(xrange,sg.rayleigh.b);
    dados = DATA.sg(tpdf,:);
elseif tpdf == 4
    yrange = lognpdf(xrange,sg.logn.mu,sg.logn.std);
    dados = DATA.sg(tpdf,:);
elseif tpdf == 5
    yrange  = gampdf(xrange,sg.gamma.A,sg.gamma.B);
    dados = DATA.sg(tpdf,:);
end

[le,ld] = tail_choice_pdf(xrange,yrange,0.1);
[le.data,ld.data,T] = tail_choice_data(dados,0.1);
