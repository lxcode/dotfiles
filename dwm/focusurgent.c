void 
focusurgent(Arg *x) {
	Client *c;
	for(c = selmon->stack; c && !(c->isurgent); c = c->snext);
	if(c) { 
		Arg a;
		a.ui=c->tags;
		view(&a);
		focus(c);
	}
}
