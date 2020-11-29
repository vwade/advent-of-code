
########################################################	MAIN MAKEFILE	####
####	CONTROL PANEL	########################################################

NAME		:=	ft_ls
BUILDDIR	:=	build
INCLDIR		:=	include
CDIR		:=	source
ODIR		:=	obj
LDIR		:=	libft
LINCL		:=	$(LDIR)/include
LIBFT		:=	$(LDIR)/libft.a
CFILES		:=	$(shell find $(CDIR) ! -name "._*" -regex ".*\\.[c]")
HFILES		:=	$(shell find $(INCLDIR) ! -name "._*" -regex ".*\\.[h]")
LFILES		:=	$(shell find $(dir $(LIBFT)) ! -name "._*" -regex ".*\\.[c]")
INCLUDE		:=	-I $(abspath $(INCLDIR)) -I $(abspath $(LINCL))
FLAGS		:=	$(INCLUDE) -Wall -Wextra
FLAGS		:=	$(FLAGS) -Werror
MAKEFLAGS	+=	-r


####	DEBUGGING		########################################################

DEBUGF		:=	$(INCLUDE) -Wall -Wextra -g

####	AUTO SETTING	########################################################

ODIR		:=	$(addprefix $(BUILDDIR)/, $(ODIR))
OBJECTS		:=	$(addprefix $(ODIR)/, $(notdir $(CFILES:%.c=%.o)))

####	UNDER THE HOOD	########################################################

all: $(NAME)

test: test.c
	@gcc -g $(INCLUDE) $(LIBFT) $^

beta: $(CFILES) $(LFILES)
	@gcc $(DEBUGF) -o ls_beta $^

$(NAME): $(LIBFT) $(OBJECTS)
	@gcc $(FLAGS) -o $@ -L $(<D) -lft $(OBJECTS)

$(ODIR)/%.o: $(CDIR)/*/%.c | $(ODIR)
	@cd $(@D); gcc -c $(FLAGS) $(abspath $^)
#	@cd $(@D); gcc -c $(FLAGS) $(abspath $^)
#	@cd $(@D); $(foreach srcf, $(abspath $^), gcc -c $(FLAGS) $(srcf);)

$(LIBFT): | $(ODIR)
	@make -C $(@D)

$(ODIR):
	@mkdir -p $@

clean:
	@rm -rf $(ODIR);\
		make clean -C $(dir $(LIBFT))

fclean:
	@rm -rf $(NAME) $(BUILDDIR);\
		make fclean -C $(dir $(LIBFT))

re: fclean all

.PHONY: clean fclean all re test
