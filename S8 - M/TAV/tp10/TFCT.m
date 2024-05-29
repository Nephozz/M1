function Y = TFCT(y, f_ech, N, D, fenetre)
    
    nb_frame = (N - D);
    data = buffer(y, N, nb_frame, 'nodelay');

    if fenetre == 'hann'
        f = hann(N);
    elseif fenetre == 'rect'
        f = rectwin(N);
    end
    
    Y = fft(f .* data);
    Y = Y(1:floor(size(Y,1)/2)+1,:);

end