
# Check for an interactive session
[ -z "$PS1" ] && return

## Path ##
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/core_perl:/home/klim/Scripts/"
export EDITOR='gvim'
export DE='xfce'
## Aliases ##
alias ls='ls --color=auto --group-directories-first'
alias pacman='sudo pacman'
alias cdd='cd /home/klim/Downloads/'
alias me='medit'
alias grep='grep --color=auto'
alias bashrc-up='source ~/.bashrc'
alias sizeof='du -sh'
alias server='sh ~/Scripts/ssh-wastedwombat.sh'
alias quit='exit'
alias archey='archey3'
alias la='ls -A'
alias lr='la -R | grep'
alias temp='sensors'
alias temps='sensors'
alias mb='sh /home/klim/mb.sh'
alias targz='tar -zcvf'
alias playiso='sh ~/Scripts/mplayer-help.sh && mplayer -really-quiet'
alias umountiso='sudo umount /mnt/iso'
alias pulsectl='pavucontrol'
alias diablo='sh ~/Scripts/diablo.sh'
alias orphan-remove='pacman -Rs $(pacman -Qqtd)'
alias spideroak='SpiderOak -v --headless'
alias intellij-idea-community-edition='/usr/bin/idea.sh'
alias t='todo.sh -d ~/Scripts/todo.cfg'
alias colortest="python -c \"print('\n'.join([(' '.join([('\033[38;5;' + str((i + j)) + 'm' + str((i + j)).ljust(5) + '\033[0m') if i + j < 256 else '' for j in range(10)])) for i in range(0, 256, 10)]))\""
source ~/Scripts/todo_completion
complete -F _todo t

## Count lines ##
countlines () 
{
    find . -name '*'$1 | xargs wc -l  
}

## Easy Extract ##
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.r00)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Search wikipedia or the Arch wiki from command line
wiki()
{
    firefox http://en.wikipedia.org/wiki/$1
}

archwiki()
{
    firefox http://wiki.archlinux.org/index.php/$1
}

findpackage()
{
    firefox http://www.archlinux.org/packages/?q=$1
}

mountiso() 
{
  if [ "`mount | grep /mnt/iso`" ]; then
    echo "/mnt/iso is already in use"
    return
  fi
  if [ ! "$1" ]; then
    echo "missing iso image argument"
    return
  fi
  if [ ! -f $1 ]; then
    echo "$1: iso image not found"
    return
  fi
  sudo mount -t iso9660 -o loop,ro $1 /mnt/iso
}

####################################################
# Different filetypes should have different colors #
####################################################

# Text files
LS_TEXT_FILES=(80 txt TXT xml log conf cfg html htm css doc docx xls odt ppt pptx pdf)
# Programming files
LS_PROG_FILES=(202 js py rb c cpp sh pl php cer cfm csr jsp java cshtml cs)
# Archive files
LS_ARCH_FILES=(190 zip 7z Z rar tar.gz tar tar.xz tar.bz2 bz2 gz tbz2 tgz)
# Picture files
LS_PIC_FILES=(11 jpg png jpeg gif bmp)
# Torrent files
LS_TOR_FILES=(40 torrent)
# Image files
LS_IMG_FILES=(38 img iso)

LS_FILE_EXTS=(LS_TEXT_FILES LS_PROG_FILES LS_ARCH_FILES LS_PIC_FILES LS_TOR_FILES LS_IMG_FILES)

LS_COLORS=""
for e in ${LS_FILE_EXTS[*]}; do
eval c=(\${$e[*]})
  for ((i=1; i<${#c[@]}; i++)) do
LS_COLORS="$LS_COLORS:*.${c[$i]}=38;5;${c[0]}"
  done
done

export LS_COLORS="$LS_COLORS:di=1;38;5;32"


## COLORS ##
TXTBLK='\[\e[0;30m\]' # Black - Regular
TXTRED='\[\e[0;31m\]' # Red
TXTGRN='\[\e[0;32m\]' # Green
TXTYLW='\[\e[0;33m\]' # Yellow
TXTBLU='\[\e[0;34m\]' # Blue
TXTPUR='\[\e[0;35m\]' # Purple
TXTCYN='\[\e[0;36m\]' # Cyan
TXTWHT='\[\e[0;37m\]' # White
BLDBLK='\[\e[1;30m\]' # Black - Bold
BLDRED='\[\e[1;31m\]' # Red
BLDGRN='\[\e[1;32m\]' # Green
BLDYLW='\[\e[1;33m\]' # Yellow
BLDBLU='\[\e[1;34m\]' # Blue
BLDPUR='\[\e[1;35m\]' # Purple
BLDCYN='\[\e[1;36m\]' # Cyan
BLDWHT='\[\e[1;37m\]' # White
UNDBLK='\[\e[4;30m\]' # Black - Underline
UNDRED='\[\e[4;31m\]' # Red
UNDGRN='\[\e[4;32m\]' # Green
UNDYLW='\[\e[4;33m\]' # Yellow
UNDBLU='\[\e[4;34m\]' # Blue
UNDPUR='\[\e[4;35m\]' # Purple
UNDCYN='\[\e[4;36m\]' # Cyan
UNDWHT='\[\e[4;37m\]' # White
BAKBLK='\[\e[40m\]'   # Black - Background
BAKRED='\[\e[41m\]'   # Red
BAKGRN='\[\e[42m\]'   # Green
BAKYLW='\[\e[43m\]'   # Yellow
BAKBLU='\[\e[44m\]'   # Blue
BAKPUR='\[\e[45m\]'   # Purple
BAKCYN='\[\e[46m\]'   # Cyan
BAKWHT='\[\e[47m\]'   # White
TXTRST='\[\e[0m\]'    # Text Reset


## STUFF ##
##PS1='[\u@\h \W]\$ '
export PS1="┌─( $TXTGRN\u$TXTRST ) - ( $TXTCYN\w$TXTRST )\n└─> "


