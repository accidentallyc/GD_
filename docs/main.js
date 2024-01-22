const {createApp, ref} = Vue

function main() {
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
                <div v-for="group in directoryItems" class="pad-p5">
                    <template v-if="group.items.length > 0">
                        <b>{{ group.category }}</b>
                        <ul>
                            <li v-for="(d) in group.items" :key="d.name" :class="{ 'is_pending': d.is_pending }">
                                <a :href="'#' + d.name">
                                {{ d.name }}
                                </a>
                            </li>
                        </ul>
                    </template>
                </div>
            </div>
        </div>
        <div class="panel-container bg-panel" id="contents">
            <div class="panel">
                <div v-for="(group) in data" :key="group.category" :id="group.category">
                    <h1 class="pad-p5">"<i class="magenta">{{ group.category }}</i>" methods</h1>
                    <template v-for="(d) in group.items" :key="d.name" >
                        <h1 :id="d.name" class="bg-gray pad-p5">GD_.{{ d.name }}</h1>
                    
                        <ContentComponent v-if="!d.is_pending" :d="d" />
                        <div v-if="d.is_pending" class="pad-1">
                            Not Yet Implemented    
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
            <div v-if="d.descp">{{d.descp.join("")}}</div>
            
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
                    <code>
                        <template v-for="(d) in d.example">{{d}}<br/></template>
                    </code>
                </div>
            </template>
            
            <template v-if="d.comparison">
                <h2>JS Comparison</h2>
                <template v-for="text in d.comparison">
                    <i class="left-2 gray" >{{text}}</i><br/>
                </template>
            </template>
        </div>
    `,
}

main()
