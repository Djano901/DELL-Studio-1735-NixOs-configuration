# colors.nix
{
	# Thème : Tokyo Night Storm
	palette = {
		# Rôles de fond
		bg_main			= "#24283b";
		bg_alt			= "#1f2335";

		# Rôle de texte
		fg_main			= "#a9b1d6";
		fg_muted		= "#787c99";

		# Rôle d'état
		accent			= "#7aa2f7"; # Couleur d'identité du thème
		active			= "#bb9af7"; # Elément actif/sélectionné
		urgent			= "#f7768e"; # Erreur, batterie critique, urgence
		success			= "#73daca"; # Confirmation, batterie pleine
		warning			= "#e0af68"; # Avertissement
	
		# Rôles de bordure
		border_focus	= "#7aa2f7";
		border_normal	= "#292e42";
	};
}
