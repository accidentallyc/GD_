const {createApp, ref} = Vue

function main() {
    for(var group of window.data) {
        
        for(var item of group.items) {
            item.display_args = item.arguments 
                ? item.arguments.map(a => a[0].split(" ")[0]).join(", ")
                : ""
        }
    }

    const app = createApp({
        setup() {
            const directoryItems = ref(window.data);
            const needle = ref('')

            return {
                data: window.data,
                needle,
                directoryItems,
                onSearchDirectory : _.debounce(() => {
                    var result = window.data.map((group) => {
                        return {
                            ...group,
                            items: _.filter(group.items, (v) => _.includes(v.name, needle.value))
                        }
                    })
                    directoryItems.value = result
                },150)
            }
        },
        components: {
            ContentComponent
        },
        template: `
        <div class="panel-container bg-panel" id="directory">
            <div class="panel">
                <input type="text" id="search" @keyup="onSearchDirectory()" v-model="needle" class="bg-dark" placeholder="Search method name..."/>
                <template v-for="group in directoryItems">
                    <div class="pad-p5"  v-if="group.items.length > 0">
                        <b>{{ group.category }}</b>
                        <ul>
                            <li v-for="(d) in group.items" :key="d.name" :class="{ 'is_pending': d.is_pending }">
                                <a :href="'#' + d.name">
                                {{ d.name }}
                                </a>
                            </li>
                        </ul>
                    </div>
                </template>
            </div>
        </div>
        <div class="panel-container bg-panel" id="contents">
            <div class="panel">
                <div v-for="(group) in data" :key="group.category" :id="group.category">
                    <h1 class="pad-p5">"<i class="magenta">{{ group.category }}</i>" methods</h1>
                    <template v-for="(d) in group.items" :key="d.name" >
                        <h1 :id="d.name" class="bg-gray pad-p5">GD_.{{ d.name }}<span class="gray">( {{ d.display_args }} )</span></h1>
                    
                        <ContentComponent v-if="!d.is_pending" :d="d" />
                        <div v-if="d.is_pending" class="pad-1">
                            <i>Not yet implemented</i>
                        </div>
                    </template>

                </div>
            </div>
        </div>
        `
    }).mount('#app')
}

const ContentComponent = {
    props: ['d'],
    template: `
        <div class="pad-1">
            <div v-if="d.descp">{{d.descp.join(" ")}}</div>

            <template v-if="d.equivalent == false">
                <i>This function has no lodash equivalent</i>
            </template>
            <template v-if="d.equivalent != false">
                <p>
                    <i>This function is based on lodash's 
                        <a :href="\`https://lodash.com/docs/4.17.15#\${_.camelCase(d.name)}\`">{{_.camelCase(d.name)}}</a>
                    </i>
                </p>
            </template>
            
            
            <template v-if="d.arguments">
                <h2>Arguments</h2>
                <template v-for="arg in d.arguments">
                    <i class="left-2 green">{{arg[0]}}</i>
                    : {{arg[1]}}
                    <br/>
                </template>
                
            </template>
            
            <template v-if="d.returns">
                <h2>Returns</h2>
                <i class="left-2 green">{{d.returns[0]}}</i>
                : {{d.returns[1]}}
            </template>
                        
            <template v-if="d.example">
                <h2>Example</h2>
                <div class="bg-dark pad-1">
                    <pre><code><template v-for="(d) in d.example">{{d}}<br/></template></code></pre>
                </div>
            </template>
            
            <template v-if="d.notes">
                <h2>Notes</h2>
                <template v-for="text in d.notes">
                    <i class="left-2 gray" >{{text}}</i><br/>
                </template>
            </template>
        </div>
    `,
}

main()
