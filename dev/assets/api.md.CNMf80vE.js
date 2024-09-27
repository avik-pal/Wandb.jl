import{_ as n,c as l,m as s,a as i,J as t,a7 as a,E as p,o as h}from"./chunks/framework.DHEZZgeo.js";const Rs=JSON.parse('{"title":"API Reference","description":"","frontmatter":{},"headers":[],"relativePath":"api.md","filePath":"api.md","lastUpdated":null}'),o={name:"api.md"},d=a('<h1 id="API-Reference" tabindex="-1">API Reference <a class="header-anchor" href="#API-Reference" aria-label="Permalink to &quot;API Reference {#API-Reference}&quot;">​</a></h1><h2 id="Core-Functionalities" tabindex="-1">Core Functionalities <a class="header-anchor" href="#Core-Functionalities" aria-label="Permalink to &quot;Core Functionalities {#Core-Functionalities}&quot;">​</a></h2><p>For a lot of these functions, the <a href="https://docs.wandb.ai/" target="_blank" rel="noreferrer">official WanDB docs</a> can provide more comprehensive details.</p>',3),r={class:"jldocstring custom-block",open:""},c=s("a",{id:"Wandb.WandbLogger",href:"#Wandb.WandbLogger"},[s("span",{class:"jlbinding"},"Wandb.WandbLogger")],-1),k=a(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(; project, name</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">nothing</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, min_level</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Info, step_increment</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">            start_step</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">0</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Create a WandbLogger that logs to the wandb project <code>project</code>. See the documentation for <code>wandb.init</code> for more details (also accessible in the Julia REPL using <code>? Wandb.wandb.init</code>).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>`,3),g={class:"jldocstring custom-block",open:""},b=s("a",{id:"Wandb.increment_step!",href:"#Wandb.increment_step!"},[s("span",{class:"jlbinding"},"Wandb.increment_step!")],-1),_=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">increment_step!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, Δstep)</span></span></code></pre></div><p>Increment the global step by <code>Δstep</code> and return the new global step.</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),u={class:"jldocstring custom-block",open:""},E=s("a",{id:"Wandb.update_config!",href:"#Wandb.update_config!"},[s("span",{class:"jlbinding"},"Wandb.update_config!")],-1),y=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">update_config!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, dict</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Dict</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>For more details checkout <code>wandb.config</code> (or <code>? Wandb.wandb.config</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),m={class:"jldocstring custom-block",open:""},F=s("a",{id:"Wandb.get_config",href:"#Wandb.get_config"},[s("span",{class:"jlbinding"},"Wandb.get_config")],-1),C=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">get_config</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Return the current config dict.</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">get_config</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, key</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Get the value of <code>key</code> from the config.</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',6),f={class:"jldocstring custom-block",open:""},j=s("a",{id:"Wandb.save",href:"#Wandb.save"},[s("span",{class:"jlbinding"},"Wandb.save")],-1),T=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">save</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, args</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Ensure all files matching <code>glob_str</code> are synced to wandb with the policy specified. For more details checkout <code>wandb.save</code> (or <code>? Wandb.wandb.save</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),A={class:"jldocstring custom-block",open:""},W=s("a",{id:"Wandb.version",href:"#Wandb.version"},[s("span",{class:"jlbinding"},"Wandb.version")],-1),v=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">version</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()</span></span></code></pre></div><p>Return the Wandb python client version number (i.e., <code>Wandb.wandb.__version__</code>).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),S={class:"jldocstring custom-block",open:""},D=s("a",{id:"Wandb.update_client",href:"#Wandb.update_client"},[s("span",{class:"jlbinding"},"Wandb.update_client")],-1),P=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">update_client</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()</span></span></code></pre></div><p>Updates the python dependencies in <code>Wandb.jl</code>.</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),B={class:"jldocstring custom-block",open:""},w=s("a",{id:"Wandb.log",href:"#Wandb.log"},[s("span",{class:"jlbinding"},"Wandb.log")],-1),I=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">log</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, logs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Dict</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>For more details checkout <code>wandb.log</code> (or <code>? Wandb.wandb.log</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),V={class:"jldocstring custom-block",open:""},x=s("a",{id:"Wandb.logable_propertynames",href:"#Wandb.logable_propertynames"},[s("span",{class:"jlbinding"},"Wandb.logable_propertynames")],-1),R=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">logable_propertynames</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(val</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Any</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Returns a tuple with the name of the fields of the structure <code>val</code> that should be logged to Wandb. This function should be overridden when you want Wandb to ignore some fields in a structure when logging it. The default behaviour is to return the same result as <code>propertynames</code>.</p><p>See also: <a href="https://docs.julialang.org/en/v1/base/base/#Base.propertynames" target="_blank" rel="noreferrer"><code>Base.propertynames</code></a></p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',4),O={class:"jldocstring custom-block",open:""},N=s("a",{id:"Base.close",href:"#Base.close"},[s("span",{class:"jlbinding"},"Base.close")],-1),L=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">close</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Terminate the current run. For more details checkout <code>wandb.finish</code> (or <code>? Wandb.wandb.finish</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),H=s("h2",{id:"plotting",tabindex:"-1"},[i("Plotting "),s("a",{class:"header-anchor",href:"#plotting","aria-label":'Permalink to "Plotting"'},"​")],-1),J={class:"jldocstring custom-block",open:""},M=s("a",{id:"Wandb.plot_line",href:"#Wandb.plot_line"},[s("span",{class:"jlbinding"},"Wandb.plot_line")],-1),q=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">plot_line</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(table</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">wandb.Table</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, x</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, y</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, stroke</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, title</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Construct a line plot.</p><p><strong>Arguments:</strong></p><ul><li><p>table (wandb.Table): Table of data.</p></li><li><p>x (string): Name of column to as for x-axis values.</p></li><li><p>y (string): Name of column to as for y-axis values.</p></li><li><p>stroke (string): Name of column to map to the line stroke scale.</p></li><li><p>title (string): Plot title.</p></li></ul><p><strong>Returns:</strong></p><p>A plot object, to be passed to Wandb.log()</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',7),U={class:"jldocstring custom-block",open:""},$=s("a",{id:"Wandb.plot_scatter",href:"#Wandb.plot_scatter"},[s("span",{class:"jlbinding"},"Wandb.plot_scatter")],-1),z=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">plot_scatter</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(table</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Py</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, x</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, y</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, title</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Construct a scatter plot.</p><p><strong>Arguments:</strong></p><ul><li><p>table (wandb.Table): Table of data.</p></li><li><p>x (string): Name of column to as for x-axis values.</p></li><li><p>y (string): Name of column to as for y-axis values.</p></li><li><p>title (string): Plot title.</p></li></ul><p><strong>Returns:</strong></p><p>A plot object, to be passed to Wandb.log()</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',7),G={class:"jldocstring custom-block",open:""},K=s("a",{id:"Wandb.plot_histogram",href:"#Wandb.plot_histogram"},[s("span",{class:"jlbinding"},"Wandb.plot_histogram")],-1),Q=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">plot_histogram</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(table</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Py</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, value</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, title</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Construct a histogram plot.</p><p><strong>Arguments:</strong></p><ul><li><p>table (wandb.Table): Table of data.</p></li><li><p>value (string): Name of column to use as data for bucketing.</p></li><li><p>title (string): Plot title.</p></li></ul><p><strong>Returns:</strong></p><p>A plot object, to be passed to Wandb.log()</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',7),X={class:"jldocstring custom-block",open:""},Y=s("a",{id:"Wandb.plot_bar",href:"#Wandb.plot_bar"},[s("span",{class:"jlbinding"},"Wandb.plot_bar")],-1),Z=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">plot_bar</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(table</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Py</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, label</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, value</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, title</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Construct a bar plot.</p><p><strong>Arguments:</strong></p><ul><li><p>table (wandb.Table): Table of data.</p></li><li><p>label (string): Name of column to use as each bar&#39;s label.</p></li><li><p>value (string): Name of column to use as each bar&#39;s value.</p></li><li><p>title (string): Plot title.</p></li></ul><p><strong>Returns:</strong></p><p>A plot object, to be passed to Wandb.log()</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',7),ss={class:"jldocstring custom-block",open:""},is=s("a",{id:"Wandb.plot_line_series",href:"#Wandb.plot_line_series"},[s("span",{class:"jlbinding"},"Wandb.plot_line_series")],-1),as=a(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">plot_line_series</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(xs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractVecOrMat</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, ys</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractMatrix</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, keys</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractVector</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">                 title</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, xname</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Construct a line series plot.</p><p><strong>Arguments:</strong></p><ul><li><p>xs (AbstractMatrix or AbstractVector): Array of arrays of x values</p></li><li><p>ys (AbstractMatrix): Array of y values</p></li><li><p>keys (AbstractVector): Array of labels for the line plots</p></li><li><p>title (string): Plot title.</p></li><li><p>xname (string): Title of x-axis</p></li></ul><p><strong>Returns:</strong></p><p>A plot object, to be passed to Wandb.log()</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>`,7),es=s("div",{class:"tip custom-block"},[s("p",{class:"custom-block-title"},"Note"),s("p",null,"We don't provide direct bindings for the other plotting functions. PRs implementing these are welcome.")],-1),ts=s("h2",{id:"Loggable-Objects",tabindex:"-1"},[i("Loggable Objects "),s("a",{class:"header-anchor",href:"#Loggable-Objects","aria-label":'Permalink to "Loggable Objects {#Loggable-Objects}"'},"​")],-1),ns={class:"jldocstring custom-block",open:""},ls=s("a",{id:"Wandb.Image",href:"#Wandb.Image"},[s("span",{class:"jlbinding"},"Wandb.Image")],-1),ps=a(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Image</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(img</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractArray{T, 3}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Image</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(img</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractMatrix</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Image</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(img</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Union{String, IO}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Creates a <code>wandb.Image</code> object that can be logged using <code>Wandb.log</code>. For more details checkout <code>wandb.Image</code> (or <code>? Wandb.wandb.Image</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>`,3),hs={class:"jldocstring custom-block",open:""},os=s("a",{id:"Wandb.Video",href:"#Wandb.Video"},[s("span",{class:"jlbinding"},"Wandb.Video")],-1),ds=a(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Video</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(vid</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractArray{T, 5}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Video</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(vid</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractArray{T, 4}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Video</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(vid</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Union{String, IO}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Creates a <code>wandb.Video</code> object that can be logged using <code>Wandb.log</code>. For more details checkout <code>wandb.Video</code> (or <code>? Wandb.wandb.Video</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>`,3),rs={class:"jldocstring custom-block",open:""},cs=s("a",{id:"Wandb.Histogram",href:"#Wandb.Histogram"},[s("span",{class:"jlbinding"},"Wandb.Histogram")],-1),ks=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Wandb</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Histogram</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(args</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Creates a <code>wandb.Histogram</code> object that can be logged using <code>Wandb.log</code>. For more details checkout <code>wandb.Histogram</code> (or <code>? Wandb.wandb.Histogram</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),gs={class:"jldocstring custom-block",open:""},bs=s("a",{id:"Wandb.Object3D",href:"#Wandb.Object3D"},[s("span",{class:"jlbinding"},"Wandb.Object3D")],-1),_s=a(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Object3D</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(path_or_io</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Union{String, IO}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Object3D</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(data</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractMatrix</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Creates a <code>wandb.Object3D</code> object that can be logged using <code>Wandb.log</code>. For more details checkout <code>wandb.Object3D</code> (or <code>? Wandb.wandb.Object3D</code> in the Julia REPL).</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>`,3),us={class:"jldocstring custom-block",open:""},Es=s("a",{id:"Wandb.Table",href:"#Wandb.Table"},[s("span",{class:"jlbinding"},"Wandb.Table")],-1),ys=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Table</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(; data</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractMatrix</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, columns</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractVector</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Creates a <code>wandb.Table</code> object that can be logged using <code>Wandb.log</code>. For more details checkout <code>wandb.Table</code> (or <code>? Wandb.wandb.Table</code> in the Julia REPL).</p><div class="tip custom-block"><p class="custom-block-title">Note</p><p>Currently we don&#39;t support passing DataFrame to the Table. (PRs implementing this are welcome)</p></div><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',4),ms=s("h2",{id:"artifacts",tabindex:"-1"},[i("Artifacts "),s("a",{class:"header-anchor",href:"#artifacts","aria-label":'Permalink to "Artifacts"'},"​")],-1),Fs={class:"jldocstring custom-block",open:""},Cs=s("a",{id:"Wandb.WandbArtifact",href:"#Wandb.WandbArtifact"},[s("span",{class:"jlbinding"},"Wandb.WandbArtifact")],-1),fs=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbArtifact</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(args</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; kwargs</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">...</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>WandbArtifact is a wrapper around <code>wandb.Artifact</code>. See the documentation for <code>wandb.Artifact</code> for the different functionalities. Most of the functions can be called using <code>Wandb.&lt;function name&gt;(::WandbArticact, args...; kwargs...)</code>.</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',3),js=s("h2",{id:"Hyper-Parameter-Sweep",tabindex:"-1"},[i("Hyper Parameter Sweep "),s("a",{class:"header-anchor",href:"#Hyper-Parameter-Sweep","aria-label":'Permalink to "Hyper Parameter Sweep {#Hyper-Parameter-Sweep}"'},"​")],-1),Ts={class:"jldocstring custom-block",open:""},As=s("a",{id:"Wandb.WandbHyperParameterSweep",href:"#Wandb.WandbHyperParameterSweep"},[s("span",{class:"jlbinding"},"Wandb.WandbHyperParameterSweep")],-1),Ws=a('<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">WandbHyperParameterSweep</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()</span></span></code></pre></div><p>Create a Wandb Hyperparameter Sweep. Unlike the <code>wandb.agent</code> API, this API needs to be manually combined with some Hyper Parameter Optimization package like <code>HyperOpt.jl</code>.</p><p>See the tutorials for more details.</p><p><a href="https://github.com/avik-pal/Wandb.jl" target="_blank" rel="noreferrer">source</a></p>',4),vs=a('<h2 id="index" tabindex="-1">Index <a class="header-anchor" href="#index" aria-label="Permalink to &quot;Index&quot;">​</a></h2><ul><li><a href="#Wandb.WandbArtifact"><code>Wandb.WandbArtifact</code></a></li><li><a href="#Wandb.WandbHyperParameterSweep"><code>Wandb.WandbHyperParameterSweep</code></a></li><li><a href="#Wandb.WandbLogger"><code>Wandb.WandbLogger</code></a></li><li><a href="#Base.close"><code>Base.close</code></a></li><li><a href="#Wandb.Histogram"><code>Wandb.Histogram</code></a></li><li><a href="#Wandb.Image"><code>Wandb.Image</code></a></li><li><a href="#Wandb.Object3D"><code>Wandb.Object3D</code></a></li><li><a href="#Wandb.Table"><code>Wandb.Table</code></a></li><li><a href="#Wandb.Video"><code>Wandb.Video</code></a></li><li><a href="#Wandb.get_config"><code>Wandb.get_config</code></a></li><li><a href="#Wandb.increment_step!"><code>Wandb.increment_step!</code></a></li><li><a href="#Wandb.log"><code>Wandb.log</code></a></li><li><a href="#Wandb.logable_propertynames"><code>Wandb.logable_propertynames</code></a></li><li><a href="#Wandb.plot_bar"><code>Wandb.plot_bar</code></a></li><li><a href="#Wandb.plot_histogram"><code>Wandb.plot_histogram</code></a></li><li><a href="#Wandb.plot_line"><code>Wandb.plot_line</code></a></li><li><a href="#Wandb.plot_line_series"><code>Wandb.plot_line_series</code></a></li><li><a href="#Wandb.plot_scatter"><code>Wandb.plot_scatter</code></a></li><li><a href="#Wandb.save"><code>Wandb.save</code></a></li><li><a href="#Wandb.update_client"><code>Wandb.update_client</code></a></li><li><a href="#Wandb.update_config!"><code>Wandb.update_config!</code></a></li><li><a href="#Wandb.version"><code>Wandb.version</code></a></li></ul>',2);function Ss(Ds,Ps,Bs,ws,Is,Vs){const e=p("Badge");return h(),l("div",null,[d,s("details",r,[s("summary",null,[c,i(),t(e,{type:"info",class:"jlObjectType jlType",text:"Type"})]),k]),s("details",g,[s("summary",null,[b,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),_]),s("details",u,[s("summary",null,[E,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),y]),s("details",m,[s("summary",null,[F,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),C]),s("details",f,[s("summary",null,[j,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),T]),s("details",A,[s("summary",null,[W,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),v]),s("details",S,[s("summary",null,[D,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),P]),s("details",B,[s("summary",null,[w,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),I]),s("details",V,[s("summary",null,[x,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),R]),s("details",O,[s("summary",null,[N,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),L]),H,s("details",J,[s("summary",null,[M,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),q]),s("details",U,[s("summary",null,[$,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),z]),s("details",G,[s("summary",null,[K,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),Q]),s("details",X,[s("summary",null,[Y,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),Z]),s("details",ss,[s("summary",null,[is,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),as]),es,ts,s("details",ns,[s("summary",null,[ls,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),ps]),s("details",hs,[s("summary",null,[os,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),ds]),s("details",rs,[s("summary",null,[cs,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),ks]),s("details",gs,[s("summary",null,[bs,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),_s]),s("details",us,[s("summary",null,[Es,i(),t(e,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),ys]),ms,s("details",Fs,[s("summary",null,[Cs,i(),t(e,{type:"info",class:"jlObjectType jlType",text:"Type"})]),fs]),js,s("details",Ts,[s("summary",null,[As,i(),t(e,{type:"info",class:"jlObjectType jlType",text:"Type"})]),Ws]),vs])}const Os=n(o,[["render",Ss]]);export{Rs as __pageData,Os as default};
