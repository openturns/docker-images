# ArchLinux image to compile otfmi module

FROM openturns/archlinux-module

# Install packages from AUR
RUN aurman -Syu --noconfirm --noedit --pgp_fetch sundials-seq python-pyfmi python-pythonfmu python-fmpy-sundials6 openmodelica-omlibraries jdk-openjdk python-sphinxcontrib-bibtex python-sphinx-renku-theme
