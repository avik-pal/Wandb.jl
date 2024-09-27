import{_ as s,c as a,o as i,a7 as t}from"./chunks/framework.JEGucrof.js";const E=JSON.parse('{"title":"Wandb Artifacts","description":"","frontmatter":{},"headers":[],"relativePath":"examples/artifacts.md","filePath":"examples/artifacts.md","lastUpdated":null}'),e={name:"examples/artifacts.md"},n=t(`<h1 id="Wandb-Artifacts" tabindex="-1">Wandb Artifacts <a class="header-anchor" href="#Wandb-Artifacts" aria-label="Permalink to &quot;Wandb Artifacts {#Wandb-Artifacts}&quot;">​</a></h1><p>All the methods listed in <a href="https://docs.wandb.ai/ref/python/artifact" target="_blank" rel="noreferrer">https://docs.wandb.ai/ref/python/artifact</a> can be used by passing a <code>WandbArtifact</code> instance as the first argument. Additionally, <code>log</code> should be used instead of <code>log_artifact</code> function.</p><p>NOTE: These functions are not exported. So use them as <code>Wandb.&lt;function&gt;(::WandbArtifact, ...)</code></p><h3 id="Example-Usage:" tabindex="-1">Example Usage: <a class="header-anchor" href="#Example-Usage:" aria-label="Permalink to &quot;Example Usage: {#Example-Usage:}&quot;">​</a></h3><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Wandb</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lg </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> WandbLogger</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(project </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;"> &quot;Wandb.jl&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">wa </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> WandbArtifact</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;some-dataset&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, type </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;"> &quot;dataset&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Wandb</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">add_file</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(wa, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;a.txt&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Wandb</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">log</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg, wa)</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">close</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lg)</span></span></code></pre></div><p>When uploading large artifacts it might be difficult to verify if the files are actually being uploaded or if the code is just stuck. Run the following in your terminal replacing <code>$WANDB_DIR</code> with the path to the local wandb directory:</p><div class="language-bash vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">bash</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">tail</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> -f</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> $WANDB_DIR</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">/latest_run/debug-internal.log</span></span></code></pre></div><p>If you have another wandb run started after this, you need to modify the path accordingly.</p>`,8),l=[n];function h(p,d,r,k,o,c){return i(),a("div",null,l)}const u=s(e,[["render",h]]);export{E as __pageData,u as default};
