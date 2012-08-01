static Client *
prevtiled(Client *c) {
	Client *p, *r;

	for(p = selmon->clients, r = NULL; p && p != c; p = p->next)
		if(!p->isfloating && ISVISIBLE(p))
			r = p;
	return r;
}

static void
pushup(const Arg *arg) {
	Client *c;

	if(!selmon->sel || selmon->sel->isfloating)
		return;
	if((c = prevtiled(selmon->sel))) {
		/* attach before c */
		detach(selmon->sel);
		selmon->sel->next = c;
		if(selmon->clients == c)
			selmon->clients = selmon->sel;
		else {
			for(c = selmon->clients; c->next != selmon->sel->next; c = c->next);
			c->next = selmon->sel;
		}
	} else {
		/* move to the end */
		for(c = selmon->sel; c->next; c = c->next);
		detach(selmon->sel);
		selmon->sel->next = NULL;
		c->next = selmon->sel;
	}
	focus(selmon->sel);
	arrange(NULL);
}

static void
pushdown(const Arg *arg) {
	Client *c;

	if(!selmon->sel || selmon->sel->isfloating)
		return;
	if((c = nexttiled(selmon->sel->next))) {
		/* attach after c */
		detach(selmon->sel);
		selmon->sel->next = c->next;
		c->next = selmon->sel;
	} else {
		/* move to the front */
		detach(selmon->sel);
		attach(selmon->sel);
	}
	focus(selmon->sel);
	arrange(NULL);
}
