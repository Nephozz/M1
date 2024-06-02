function u = collage_a(r,s,interieur)

	r = double(r);
	s = double(s);

	[nb_lignes,nb_colonnes,nb_canaux] = size(r);
	n_r = nb_lignes*nb_colonnes;

	e = ones(n_r,1);
	Dx = spdiags([-e e],[0 nb_lignes],n_r,n_r);
	Dx(end-nb_lignes+1:end,:) = 0;
	Dy = spdiags([-e e],[0 1],n_r,n_r);
	Dy(nb_lignes:nb_lignes:end,:) = 0;

	A = -Dx' * Dx - Dy' * Dy;
	M = ones(nb_lignes,nb_colonnes);
	M(2:nb_lignes-1,2:nb_colonnes-1) = 0;

	indices_bord_r = find(M);
	n_bord_r = length(indices_bord_r);
	A(indices_bord_r,:) = sparse(1:n_bord_r,indices_bord_r,ones(n_bord_r,1),n_bord_r,n_r);

	% Calcul de l'imagette resultat u, canal par canal :
	u = r;
	for k = 1:nb_canaux
		r_k = reshape(r(:,:,k),n_r,1);
		s_k = reshape(s(:,:,k),n_r,1);

		gx = Dx * r_k;
		gy = Dy * r_k;
		grad_sx = Dx * s_k;
		grad_sy = Dy * s_k;

		masque = (gx.^2 + gy.^2) < (grad_sx.^2 + grad_sy.^2);
		interieur = interieur(masque(interieur));
		
		gx(interieur) = grad_sx(interieur);
		gy(interieur) = grad_sy(interieur);

		bk = -Dx' * gx - Dy' * gy;
		bk(indices_bord_r) = r_k(indices_bord_r);
		u_k = A\bk;
		%u_k(interieur) = s_k(interieur);
		u(:,:,k) = reshape(u_k, nb_lignes, nb_colonnes);
	end
end