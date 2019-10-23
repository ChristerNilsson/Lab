var app=function(){"use strict";function t(){}function e(t){return t()}function n(){return Object.create(null)}function r(t){t.forEach(e)}function a(t){return"function"==typeof t}function i(t,e){return t!=t?e==e:t!==e||t&&"object"==typeof t||"function"==typeof t}function l(t,e){t.appendChild(e)}function o(t,e,n){t.insertBefore(e,n||null)}function c(t){t.parentNode.removeChild(t)}function s(t){return document.createElement(t)}function u(t){return document.createTextNode(t)}function d(){return u(" ")}function f(t,e,n,r){return t.addEventListener(e,n,r),()=>t.removeEventListener(e,n,r)}function g(t,e,n){null==n?t.removeAttribute(e):t.setAttribute(e,n)}function $(t,e){e=""+e,t.data!==e&&(t.data=e)}function m(t,e,n,r){t.style.setProperty(e,n,r?"important":"")}let p;function h(t){p=t}const v=[],b=[],x=[],w=[],y=Promise.resolve();let k=!1;function _(t){x.push(t)}function C(){const t=new Set;do{for(;v.length;){const t=v.shift();h(t),T(t.$$)}for(;b.length;)b.pop()();for(let e=0;e<x.length;e+=1){const n=x[e];t.has(n)||(n(),t.add(n))}x.length=0}while(v.length);for(;w.length;)w.pop()();k=!1}function T(t){t.fragment&&(t.update(t.dirty),r(t.before_update),t.fragment.p(t.dirty,t.ctx),t.dirty=null,t.after_update.forEach(_))}const A=new Set;let E;function j(){E={r:0,c:[],p:E}}function S(){E.r||r(E.c),E=E.p}function q(t,e){t&&t.i&&(A.delete(t),t.i(e))}function z(t,e,n,r){if(t&&t.o){if(A.has(t))return;A.add(t),E.c.push(()=>{A.delete(t),r&&(n&&t.d(1),r())}),t.o(e)}}function F(t,n,i){const{fragment:l,on_mount:o,on_destroy:c,after_update:s}=t.$$;l.m(n,i),_(()=>{const n=o.map(e).filter(a);c?c.push(...n):r(n),t.$$.on_mount=[]}),s.forEach(_)}function N(t,e){t.$$.fragment&&(r(t.$$.on_destroy),t.$$.fragment.d(e),t.$$.on_destroy=t.$$.fragment=null,t.$$.ctx={})}function P(t,e){t.$$.dirty||(v.push(t),k||(k=!0,y.then(C)),t.$$.dirty=n()),t.$$.dirty[e]=!0}function I(e,a,i,l,o,c){const s=p;h(e);const u=a.props||{},d=e.$$={fragment:null,ctx:null,props:c,update:t,not_equal:o,bound:n(),on_mount:[],on_destroy:[],before_update:[],after_update:[],context:new Map(s?s.$$.context:[]),callbacks:n(),dirty:null};let f=!1;var g;d.ctx=i?i(e,u,(t,n,r=n)=>(d.ctx&&o(d.ctx[t],d.ctx[t]=r)&&(d.bound[t]&&d.bound[t](r),f&&P(e,t)),n)):u,d.update(),f=!0,r(d.before_update),d.fragment=l(d.ctx),a.target&&(a.hydrate?d.fragment.l((g=a.target,Array.from(g.childNodes))):d.fragment.c(),a.intro&&q(e.$$.fragment),F(e,a.target,a.anchor),C()),h(s)}class L{$destroy(){N(this,1),this.$destroy=t}$on(t,e){const n=this.$$.callbacks[t]||(this.$$.callbacks[t]=[]);return n.push(e),()=>{const t=n.indexOf(e);-1!==t&&n.splice(t,1)}}$set(){}}function M(e){var n;return{c(){(n=s("section")).innerHTML='<div id="bundle-1" class="svelte-waqroa"><h1>WHO AM I</h1> <p id="about-me">Junior web developer. Extremely\n\t\t\t\t\t\tmotivated to learn more things and\n\t\t\t\t\t\tconstantly develop my skills. I worked\n\t\t\t\t\t\tpreviously with different fields, which\n\t\t\t\t\t\tmake it easy for me to adapt with all\n\t\t\t\t\t\twork environments. I am confident in\n\t\t\t\t\t\tmy ability to come up with interesting\n\t\t\t\t\t\tideas and contribute with my skills.\n\t\t\t\t\t</p></div> <div id="bundle-2" class="svelte-waqroa"><img src="./myPic.jpg" alt="photo" style="height: 240px;width: 200px;"> <h1 id="name" class="svelte-waqroa"> ahmed gozan</h1> <h4 id="adress"> koppargården 31C, Landskrona 26143</h4> <h4>0709703102</h4> <h3 id="email">ahmedgozan@yahoo.com</h3> <div id="social-media" class="svelte-waqroa"><a href="https://www.facebook.com/hurrycgfyvcbv.comghfgt" target="_blank" class="svelte-waqroa">facebook</a> <a href="https://www.linkedin.com/in/ahmad-gozan-a6b142a2/" target="_blank" class="svelte-waqroa">linkedin</a> <a href="https://github.com/full-gozan" target="_blank" class="svelte-waqroa">github</a></div></div>',g(n,"id","about-me-selection"),g(n,"class","body svelte-waqroa")},m(t,e){o(t,n,e)},p:t,i:t,o:t,d(t){t&&c(n)}}}class B extends L{constructor(t){super(),I(this,t,null,M,i,[])}}function J(e){var n,r,a,i,f,m,p,h,v;return{c(){n=s("div"),r=s("h5"),a=u(e.title),i=d(),f=s("p"),m=u(e.text),p=d(),h=s("a"),v=u("Visit repo"),g(r,"class","card-title"),g(f,"class","card-text"),g(h,"href",e.href),g(h,"class","btn btn-primary"),g(n,"class","col-sm-6 card card-body")},m(t,e){o(t,n,e),l(n,r),l(r,a),l(n,i),l(n,f),l(f,m),l(n,p),l(n,h),l(h,v)},p(t,e){t.title&&$(a,e.title),t.text&&$(m,e.text),t.href&&g(h,"href",e.href)},i:t,o:t,d(t){t&&c(n)}}}function G(t,e,n){let{title:r,text:a,href:i}=e;return t.$set=(t=>{"title"in t&&n("title",r=t.title),"text"in t&&n("text",a=t.text),"href"in t&&n("href",i=t.href)}),{title:r,text:a,href:i}}class H extends L{constructor(t){super(),I(this,t,G,J,i,["title","text","href"])}}function O(e){var n,r,a,i,u=new H({props:{title:"Foo Coding",text:"Solving the problems and exercises of fooCoding course",href:"https://github.com/full-gozan/fooCoding"}}),f=new H({props:{title:"Portfolio",text:"Create online resume, using HTML, CSS and javascript knowledge",href:"https://github.com/full-gozan/portfolio"}}),$=new H({props:{title:"learnJS",text:"Contributing the project to generate static site generator using GitBook",href:"https://github.com/full-gozan/learnjs"}});return{c(){n=s("div"),u.$$.fragment.c(),r=d(),f.$$.fragment.c(),a=d(),$.$$.fragment.c(),g(n,"class","row")},m(t,e){o(t,n,e),F(u,n,null),l(n,r),F(f,n,null),l(n,a),F($,n,null),i=!0},p:t,i(t){i||(q(u.$$.fragment,t),q(f.$$.fragment,t),q($.$$.fragment,t),i=!0)},o(t){z(u.$$.fragment,t),z(f.$$.fragment,t),z($.$$.fragment,t),i=!1},d(t){t&&c(n),N(u),N(f),N($)}}}class R extends L{constructor(t){super(),I(this,t,null,O,i,[])}}function D(e){var n,r,a,i,f,m,p,h,v,b,x,w;return{c(){n=s("div"),r=s("h5"),a=u(e.title),i=d(),f=s("h5"),m=u(e.subTitle),p=d(),h=s("p"),v=u(e.text),b=d(),x=s("a"),w=u("read about this"),g(r,"class","card-title"),g(f,"class","card-subtitle mb-2 text-muted"),g(h,"class","card-text"),g(x,"href",e.href),g(x,"class","btn btn-primary"),g(n,"class","col-sm-6 card card-body")},m(t,e){o(t,n,e),l(n,r),l(r,a),l(n,i),l(n,f),l(f,m),l(n,p),l(n,h),l(h,v),l(n,b),l(n,x),l(x,w)},p(t,e){t.title&&$(a,e.title),t.subTitle&&$(m,e.subTitle),t.text&&$(v,e.text),t.href&&g(x,"href",e.href)},i:t,o:t,d(t){t&&c(n)}}}function U(t,e,n){let{title:r,subTitle:a,text:i,href:l}=e;return t.$set=(t=>{"title"in t&&n("title",r=t.title),"subTitle"in t&&n("subTitle",a=t.subTitle),"text"in t&&n("text",i=t.text),"href"in t&&n("href",l=t.href)}),{title:r,subTitle:a,text:i,href:l}}class V extends L{constructor(t){super(),I(this,t,U,D,i,["title","subTitle","text","href"])}}function W(e){var n,r,a,i,u=new V({props:{title:"Foo Coding",subTitle:"May 2019 - Feb 2020",text:"competence course with concentrating on javascript, React, database, node.js, and Git",href:"https://foocafe.org"}}),f=new V({props:{title:"matchIT",subTitle:"Aug 2018 - Apr 2019",text:"programming training course based on Java",href:"https://luvit.education.lu.se/LUCE/activities/activitydetails_ext.aspx?id=351"}}),$=new V({props:{title:"power engineering",subTitle:"Aug 2009 - Jun 2013",text:"Bachelor degree in power engineering from University of technology, mixing between the the mechanical and electrical departments",href:"https://eee.uotechnology.edu.iq/index.php"}});return{c(){n=s("div"),u.$$.fragment.c(),r=d(),f.$$.fragment.c(),a=d(),$.$$.fragment.c(),g(n,"class","row")},m(t,e){o(t,n,e),F(u,n,null),l(n,r),F(f,n,null),l(n,a),F($,n,null),i=!0},p:t,i(t){i||(q(u.$$.fragment,t),q(f.$$.fragment,t),q($.$$.fragment,t),i=!0)},o(t){z(u.$$.fragment,t),z(f.$$.fragment,t),z($.$$.fragment,t),i=!1},d(t){t&&c(n),N(u),N(f),N($)}}}class K extends L{constructor(t){super(),I(this,t,null,W,i,[])}}function Q(e){var n,r,a,i,f,m,p,h,v,b;return{c(){n=s("div"),r=s("div"),a=u(e.header),i=d(),f=s("div"),m=s("h5"),p=u(e.title),h=d(),v=s("p"),b=u(e.text),g(r,"class","card-header"),g(m,"class","card-title"),g(v,"class","card-text"),g(f,"class","card-body"),g(n,"class","card")},m(t,e){o(t,n,e),l(n,r),l(r,a),l(n,i),l(n,f),l(f,m),l(m,p),l(f,h),l(f,v),l(v,b)},p(t,e){t.header&&$(a,e.header),t.title&&$(p,e.title),t.text&&$(b,e.text)},i:t,o:t,d(t){t&&c(n)}}}function X(t,e,n){let{header:r,title:a,text:i}=e;return t.$set=(t=>{"header"in t&&n("header",r=t.header),"title"in t&&n("title",a=t.title),"text"in t&&n("text",i=t.text)}),{header:r,title:a,text:i}}class Y extends L{constructor(t){super(),I(this,t,X,Q,i,["header","title","text"])}}function Z(e){var n,r,a,i=new Y({props:{header:"FEB 2019 - APR 2019",title:"Ikea AB",text:"implementation and using content management system to provide the API management the needs of web pages."}}),l=new Y({props:{header:"SEP 2014 - OCT 2015",title:"GE company",text:"working with a team in compression gas station rehabilitation project."}}),s=new Y({props:{header:"DEC 2013 - SEP 2014",title:"Bohai Company",text:"design web pages corresponding with the needs , fix the bugs."}});return{c(){i.$$.fragment.c(),n=d(),l.$$.fragment.c(),r=d(),s.$$.fragment.c()},m(t,e){F(i,t,e),o(t,n,e),F(l,t,e),o(t,r,e),F(s,t,e),a=!0},p:t,i(t){a||(q(i.$$.fragment,t),q(l.$$.fragment,t),q(s.$$.fragment,t),a=!0)},o(t){z(i.$$.fragment,t),z(l.$$.fragment,t),z(s.$$.fragment,t),a=!1},d(t){N(i,t),t&&c(n),N(l,t),t&&c(r),N(s,t)}}}class tt extends L{constructor(t){super(),I(this,t,null,Z,i,[])}}function et(e){var n,r,a,i,f,p;return{c(){n=s("p"),r=u(e.title),a=d(),i=s("div"),f=s("div"),p=u(e.value),g(n,"class","svelte-15dg3z2"),m(f,"width",e.value),m(f,"background-color","#"+e.bg),g(f,"class","svelte-15dg3z2"),g(i,"class","container skills svelte-15dg3z2")},m(t,e){o(t,n,e),l(n,r),o(t,a,e),o(t,i,e),l(i,f),l(f,p)},p(t,e){t.title&&$(r,e.title),t.value&&($(p,e.value),m(f,"width",e.value)),t.bg&&m(f,"background-color","#"+e.bg)},i:t,o:t,d(t){t&&(c(n),c(a),c(i))}}}function nt(t,e,n){let{title:r,value:a,bg:i}=e;return t.$set=(t=>{"title"in t&&n("title",r=t.title),"value"in t&&n("value",a=t.value),"bg"in t&&n("bg",i=t.bg)}),{title:r,value:a,bg:i}}class rt extends L{constructor(t){super(),I(this,t,nt,et,i,["title","value","bg"])}}function at(e){var n,r,a,i,u,f,$,m,p,h,v,b,x,w,y=new rt({props:{value:"80%",bg:"4CAF50",title:"HTML"}}),k=new rt({props:{value:"80%",bg:"2196F3",title:"CSS"}}),_=new rt({props:{value:"65%",bg:"f44336",title:"Javascript"}}),C=new rt({props:{value:"60%",bg:"808080",title:"React"}}),T=new rt({props:{value:"70%",bg:"4CAF50",title:"Database"}}),A=new rt({props:{value:"50%",bg:"2196F3",title:"Node.js"}}),E=new rt({props:{value:"80%",bg:"f44336",title:"Git & GitHub"}}),j=new rt({props:{value:"70%",bg:"808080",title:"Java"}}),S=new rt({props:{value:"90%",bg:"4CAF50",title:"Agile & Scrum"}}),P=new rt({props:{value:"40%",bg:"2196F3",title:"API"}}),I=new rt({props:{value:"75%",bg:"f44336",title:"Electric Engineer"}});return{c(){(n=s("h1")).textContent="My Skills",r=d(),a=s("div"),y.$$.fragment.c(),i=d(),k.$$.fragment.c(),u=d(),_.$$.fragment.c(),f=d(),C.$$.fragment.c(),$=d(),T.$$.fragment.c(),m=d(),A.$$.fragment.c(),p=d(),E.$$.fragment.c(),h=d(),j.$$.fragment.c(),v=d(),S.$$.fragment.c(),b=d(),P.$$.fragment.c(),x=d(),I.$$.fragment.c(),g(n,"class","svelte-tj7ric"),g(a,"id","frame"),g(a,"class","svelte-tj7ric")},m(t,e){o(t,n,e),o(t,r,e),o(t,a,e),F(y,a,null),l(a,i),F(k,a,null),l(a,u),F(_,a,null),l(a,f),F(C,a,null),l(a,$),F(T,a,null),l(a,m),F(A,a,null),l(a,p),F(E,a,null),l(a,h),F(j,a,null),l(a,v),F(S,a,null),l(a,b),F(P,a,null),l(a,x),F(I,a,null),w=!0},p:t,i(t){w||(q(y.$$.fragment,t),q(k.$$.fragment,t),q(_.$$.fragment,t),q(C.$$.fragment,t),q(T.$$.fragment,t),q(A.$$.fragment,t),q(E.$$.fragment,t),q(j.$$.fragment,t),q(S.$$.fragment,t),q(P.$$.fragment,t),q(I.$$.fragment,t),w=!0)},o(t){z(y.$$.fragment,t),z(k.$$.fragment,t),z(_.$$.fragment,t),z(C.$$.fragment,t),z(T.$$.fragment,t),z(A.$$.fragment,t),z(E.$$.fragment,t),z(j.$$.fragment,t),z(S.$$.fragment,t),z(P.$$.fragment,t),z(I.$$.fragment,t),w=!1},d(t){t&&(c(n),c(r),c(a)),N(y),N(k),N(_),N(C),N(T),N(A),N(E),N(j),N(S),N(P),N(I)}}}class it extends L{constructor(t){super(),I(this,t,null,at,i,[])}}function lt(e){var n;return{c(){(n=s("h1")).textContent="the page on going creating"},m(t,e){o(t,n,e)},p:t,i:t,o:t,d(t){t&&c(n)}}}class ot extends L{constructor(t){super(),I(this,t,null,lt,i,[])}}function ct(t){var e,n=new B({});return{c(){n.$$.fragment.c()},m(t,r){F(n,t,r),e=!0},i(t){e||(q(n.$$.fragment,t),e=!0)},o(t){z(n.$$.fragment,t),e=!1},d(t){N(n,t)}}}function st(t){var e,n=new R({});return{c(){n.$$.fragment.c()},m(t,r){F(n,t,r),e=!0},i(t){e||(q(n.$$.fragment,t),e=!0)},o(t){z(n.$$.fragment,t),e=!1},d(t){N(n,t)}}}function ut(t){var e,n=new K({});return{c(){n.$$.fragment.c()},m(t,r){F(n,t,r),e=!0},i(t){e||(q(n.$$.fragment,t),e=!0)},o(t){z(n.$$.fragment,t),e=!1},d(t){N(n,t)}}}function dt(t){var e,n=new tt({});return{c(){n.$$.fragment.c()},m(t,r){F(n,t,r),e=!0},i(t){e||(q(n.$$.fragment,t),e=!0)},o(t){z(n.$$.fragment,t),e=!1},d(t){N(n,t)}}}function ft(t){var e,n=new it({});return{c(){n.$$.fragment.c()},m(t,r){F(n,t,r),e=!0},i(t){e||(q(n.$$.fragment,t),e=!0)},o(t){z(n.$$.fragment,t),e=!1},d(t){N(n,t)}}}function gt(t){var e,n=new ot({});return{c(){n.$$.fragment.c()},m(t,r){F(n,t,r),e=!0},i(t){e||(q(n.$$.fragment,t),e=!0)},o(t){z(n.$$.fragment,t),e=!1},d(t){N(n,t)}}}function $t(t){var e,n,a,i,l,g,$,m,p,h,v,b,x,w,y,k,_,C,T,A,E=0==t.page&&ct(),F=1==t.page&&st(),N=2==t.page&&ut(),P=3==t.page&&dt(),I=4==t.page&&ft(),L=5==t.page&&gt();return{c(){(e=s("div")).textContent="about me",n=d(),(a=s("div")).textContent="projects",i=d(),(l=s("div")).textContent="educations",g=d(),($=s("div")).textContent="experiences",m=d(),(p=s("div")).textContent="skills",h=d(),(v=s("div")).textContent="feedback",b=d(),E&&E.c(),x=d(),F&&F.c(),w=d(),N&&N.c(),y=d(),P&&P.c(),k=d(),I&&I.c(),_=d(),L&&L.c(),C=u(""),A=[f(e,"click",t.click_handler),f(a,"click",t.click_handler_1),f(l,"click",t.click_handler_2),f($,"click",t.click_handler_3),f(p,"click",t.click_handler_4),f(v,"click",t.click_handler_5)]},m(t,r){o(t,e,r),o(t,n,r),o(t,a,r),o(t,i,r),o(t,l,r),o(t,g,r),o(t,$,r),o(t,m,r),o(t,p,r),o(t,h,r),o(t,v,r),o(t,b,r),E&&E.m(t,r),o(t,x,r),F&&F.m(t,r),o(t,w,r),N&&N.m(t,r),o(t,y,r),P&&P.m(t,r),o(t,k,r),I&&I.m(t,r),o(t,_,r),L&&L.m(t,r),o(t,C,r),T=!0},p(t,e){0==e.page?E?q(E,1):((E=ct()).c(),q(E,1),E.m(x.parentNode,x)):E&&(j(),z(E,1,1,()=>{E=null}),S()),1==e.page?F?q(F,1):((F=st()).c(),q(F,1),F.m(w.parentNode,w)):F&&(j(),z(F,1,1,()=>{F=null}),S()),2==e.page?N?q(N,1):((N=ut()).c(),q(N,1),N.m(y.parentNode,y)):N&&(j(),z(N,1,1,()=>{N=null}),S()),3==e.page?P?q(P,1):((P=dt()).c(),q(P,1),P.m(k.parentNode,k)):P&&(j(),z(P,1,1,()=>{P=null}),S()),4==e.page?I?q(I,1):((I=ft()).c(),q(I,1),I.m(_.parentNode,_)):I&&(j(),z(I,1,1,()=>{I=null}),S()),5==e.page?L?q(L,1):((L=gt()).c(),q(L,1),L.m(C.parentNode,C)):L&&(j(),z(L,1,1,()=>{L=null}),S())},i(t){T||(q(E),q(F),q(N),q(P),q(I),q(L),T=!0)},o(t){z(E),z(F),z(N),z(P),z(I),z(L),T=!1},d(t){t&&(c(e),c(n),c(a),c(i),c(l),c(g),c($),c(m),c(p),c(h),c(v),c(b)),E&&E.d(t),t&&c(x),F&&F.d(t),t&&c(w),N&&N.d(t),t&&c(y),P&&P.d(t),t&&c(k),I&&I.d(t),t&&c(_),L&&L.d(t),t&&c(C),r(A)}}}function mt(t,e,n){let r=0;return{page:r,click_handler:()=>{n("page",r=0)},click_handler_1:()=>{n("page",r=1)},click_handler_2:()=>{n("page",r=2)},click_handler_3:()=>{n("page",r=3)},click_handler_4:()=>{n("page",r=4)},click_handler_5:()=>{n("page",r=5)}}}return new class extends L{constructor(t){super(),I(this,t,mt,$t,i,[])}}({target:document.body,props:{}})}();
//# sourceMappingURL=bundle.js.map
